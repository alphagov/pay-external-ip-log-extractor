require 'logger'
require 'json'

class Matcher
  attr_reader :ips, :logger

  def initialize(logger: Logger.new(STDERR))
    @ips = {}
    @logger = logger
  end

  def read_file!(filename)
    CSV.foreach(filename, headers: true).each do |row|
      add_ip(row['xforwardedfor'], row['file'])
    end
  end

  def read_raw_file!(filename)
    CSV.foreach(filename, headers: true).each do |raw_row|
      ip, url = parse_raw_row(raw_row)
      add_ip(ip, url)
    end
  end

  def parse_raw_row(raw_row)
    message = JSON.parse(raw_row['_raw'])['message']
    if message =~ %r{[^ ]+ [^ ]+ ([^ ]+) [^ ]+ [^ ]+ \[[^\]]+\] "POST ([^ ]+)}
      ip = $1
      url = $2

      [ip, url]
    else
      logger.warn "Unable to parse raw row #{message}"
    end
  end

  def add_ip(ip, url)
    if url =~ %r{/card_details/(.*)/confirm}
      order_code = $1
      @ips[order_code] = ip
    else
      logger.warn("Unable to parse line: #{ip}, #{url}")
    end
  end

  def lookup(order_code)
    ips[order_code]
  end
end
