require 'minitest/autorun'
require 'csv'
require 'pp'

$LOAD_PATH << File.dirname(__FILE__) + "/../"
require 'matcher'

class MatcherTest < Minitest::Unit::TestCase
  def test_matching
    m = Matcher.new
    m.read_file!(File.dirname(__FILE__) + "/fixtures/sample.csv")
    assert_equal "9.9.9.9", m.lookup("wqjdoiqwjiodjqwiodoiqwjd")
  end

  def test_raw
    m = Matcher.new
    m.read_raw_file!(File.dirname(__FILE__) + "/fixtures/sample_raw.csv")
    assert_equal "1.1.1.1", m.lookup("wqjdoiqwjiodjqwiodoiqwjd2")
  end

  def test_raw2
    m = Matcher.new
    m.read_raw_file!(File.dirname(__FILE__) + "/fixtures/raw_sampled.csv")
    assert_equal "3.3.3.3", m.lookup("wqjdoiqwjiodjqwiodoiqwjd3")
  end
end
