class NumberSet
  include Enumerable
  def initialize
    @numbers = []
  end

  def each(&block)
    @numbers.each(&block)
  end

  def size
    @numbers.size
  end

  def empty?
    @numbers.empty?
  end

  def <<(other)
    @numbers<<other unless @numbers.include? other
  end

  def [](filter)
    return false if @numbers == []
    @numbers.each_with_object(NumberSet.new) do |number, new_numbers|
    new_numbers << number if(filter.filter_pass? number)
  end
end
end
class Filter
  def initialize(&block)
    @filter = block
  end

  def filter_pass?(number)
    @filter.call number
  end

  def &(filter)
    Filter.new { |number| filter_pass? number and filter.filter_pass? number }
  end

  def |(filter)
    Filter.new { |number| filter_pass? number or filter.filter_pass? number }
  end
end

class TypeFilter < Filter
  def initialize(filter_type)
    case filter_type
      when :integer then super() {|n| n.is_a? Integer}
      when :real    then super() {|n| n.is_a? Rational or x.is_a? Float}
      when :complex then super() {|n| n.is_a? Complex}
    end
  end
end

class SignFilter < Filter
  def initialize(filter_sign)
    case filter_sign
      when :positive     then super() { |x| x > 0 }
      when :negative     then super() { |x| x < 0 }
      when :non_positive then super() { |x| x <= 0 }
      when :non_negative then super() { |x| x >= 0 }
    end
  end
end