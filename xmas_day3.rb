require 'csv'
# require 'daru'
require 'matrix'
require "pry-byebug"

filepath = 'raw_data/data_day3.csv'

# df = Daru::DataFrame.from_csv(filepath)

raw_data = CSV.read(filepath)
arr = raw_data.flatten.map {|s| s.split("")}
def a_to_m (arr)
  m1 = Matrix[*arr]
  m = m1.transpose
  m.to_a
end

a = a_to_m(arr)

gamma = []
epsilon = []

a.each do | s |
  one = s.count("1")
  zero = s.count("0")
  if one > zero
    gamma << "1"
    epsilon << "0"
  else
    gamma << "0"
    epsilon << "1"
  end
end


def to_decimal(binary)
  raise ArgumentError if binary.match?(/[^01]/)

  binary.reverse.chars.map.with_index do |digit, index|
    digit.to_i * 2**index
  end.sum
end

gamma_f = to_decimal(gamma.join)
epsilon_f = to_decimal(epsilon.join)
result = gamma_f * epsilon_f
p result

# p gamma
# p epsilon
oxygen = arr
co2 = arr
12.times do |t|
  if oxygen.size > 1
    # binding.pry
    o_a = a_to_m(oxygen)
    if o_a[t].count("1") >= o_a[t].count("0")
      oxygen = oxygen.select {|a| a[t] == "1"}
    else
      oxygen = oxygen.select {|a| a[t] == "0"}
    end
  end
end

# binding.pry
# def selector(arr)
#   arr[0].size .times do |t|
#     if arr.size > 1
#       c_a = a_to_m(arr)
#       if c_a[t].count("0") <= c_a[t].count("1")
#         arr = arr.select {|a| a[t]=="0"}
#       else
#         arr = arr.select {|a| a[t] == "1"}
#       end
#     end
#   end
#   arr
# end

12.times do |t|
  if co2.size > 1
    c_a = a_to_m(co2)
    if c_a[t].count("0") <= c_a[t].count("1")
      co2 = co2.select {|a| a[t]=="0"}
    else
      co2 = co2.select {|a| a[t] == "1"}
    end
  end
end

p o = oxygen.flatten.join()
p c = co2.flatten.join()
p r = to_decimal(o) * to_decimal(c)
