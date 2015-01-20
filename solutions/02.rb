class NumberSet
  include Enumerable
  attr_accessor :numbers, :size

  def initialize
    @numbers = []
    @size = 0
  end

  def each
    @numbers.each do |number|
    yield number
    end
  end

def empty?
  if @size == 0
    return true
  end
  false
end

def <<(other)
  other.to_r
  numbers.each  do |n|
    if (n.to_r == other)
      return numbers
    end
  end
  numbers.push(other)
  @size += 1
end

def [](filter)
  new_numbers = NumberSet.new
  @numbers.select{|i| filter.valid_filter? i}.each do |number|
    new_numbers << number
  end
  new_numbers
end

def &(filter, filter_one)
  Filter.new do |number|
  filter.valid_filter? number and filter_one.valid_filter? number
  end
end

def |(filter, filter_one)
  Filter.new do |number|
  filter.valid_filter? number or filter_one.valid_filter? number
end
end
end

class SignFilter
  def initialize(filter_sign)
    @filter_sign = filter_sign
  end

  def valid_filter?(number)
    return true if(@filter_sign == :positive     and number > 0)
    return true if(@filter_sign == :non_positive and number <= 0)
    return true if(@filter_sign == :negative     and number < 0)
    return true if(@filter_sign == :non_negative and number >= 0)
    false
  end
end

class Filter
  def initialize(&block)
    @block = block
  end
  def valid_filter?(number)
    return @block.call number
  end
end

class TypeFilter
  def initialize(type)
  @type = type
  end

  def valid_filter?(number)
    return number.is_a? Integer if @type ==:integer
    if @type == :real
      if number.is_a? Rational  or number.is_a? Float
        return true
      end
    end
    return number.is_a? Complex if @type == :complex
    false
  end
end