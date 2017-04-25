require 'CSV'
require 'pp'

$LOAD_PATH << File.dirname(__FILE__)

require 'row'
require 'matcher'

rows = CSV.read("data/ips.csv", headers: true).map do |row|
  Row.new(row)
end

matcher = Matcher.new
# matcher.read_file!("search-results-2017-04-25T06-56-51.670-0700.csv")
# matcher.read_raw_file!("search-results-2017-04-25T08-39-09.783-0700.csv")
matcher.read_raw_file!("data/search-results-2017-04-25T10-14-41.231-0700.csv")

rows.each do |row|
  puts "#{row.order_code},#{matcher.lookup(row.order_code)}"
end
