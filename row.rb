
class Row
  attr_reader :row

  def initialize(row)
    @row = row
  end

  def order_code
    row['GOV.UK Pay']
  end

  def to_s
    "Order: #{order_code}"
  end
end