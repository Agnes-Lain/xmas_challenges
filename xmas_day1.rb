# require 'open-uri'
# require 'nokogiri'

# url = "https://adventofcode.com/2021/day/1/input"
# data = URI.open(url).read
# html_doc = Nokogiri::HTML(data)
# print data
# # user = JSON.parse(user_serialized)

require 'csv'

filepath = 'raw_data/data_day1.csv'

data = CSV.read(filepath).flatten.map { |s| s.to_i }

ex_num = data[0]
ex_sum = data[0..2].sum
# puts ex_sum
increase_counter = 0
data.each do |num|
  # Here, row is an array of columns
  increase_counter += 1 if num > ex_num
  ex_num = num
end

puts increase_counter

increase_counter2 = 0
data.each_with_index do |num, index|
  if index < (data.size - 2)
    swift_sum = data[index..(index+2)].sum
    increase_counter2 += 1 if swift_sum > ex_sum
    # puts swift_sum
    ex_sum = swift_sum
  end
end

puts increase_counter2

