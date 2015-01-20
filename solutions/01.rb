def fibonacci_series(number)
  return 1 if number <= 2
  fibonacci_series(number - 1) + fibonacci_series(number - 2)
end

def lucas_series(number)
  return 2 if number == 1
  return 1 if number == 2
  lucas_series(number - 1) + lucas_series(number - 2)
end

def series(kind_of_series, number)
  case kind_of_series
    when 'fibonacci' then fibonacci_series(number)
    when 'lucas'     then lucas_series(number)
    when 'summed'   then fibonacci_series(number) + lucas_series(number)
  end
end