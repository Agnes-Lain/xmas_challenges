require 'csv'
require "pry-byebug"

check_a = [50,68,2,1,69,32,87,10,31,21,78,23,62,98,16,99,65,35,27,96,66,26,74,72,45,52,81,60,38,57,54,19,18,77,71,29,51,41,22,6,58,5,42,92,85,64,94,12,83,11,17,14,37,36,59,33,0,93,34,70,97,7,76,20,3,88,43,47,8,79,80,63,9,25,56,75,15,4,82,67,39,30,89,86,46,90,48,73,91,55,95,28,49,61,44,84,40,53,13,24]
csv_options = { col_sep: ' ' }
filepath = 'raw_data/data_day4.csv'
raw_data = CSV.read(filepath, csv_options)
p raw_data.size
data = raw_data.select {|a| a.size > 0 }
p data.size
data = data.map {|a| a.compact}.map{|a| a.map{|s| s.to_i}}
data = data.each_slice(5).to_a
p data.size


def mark_bingo(matrix, num)
  matrix.map {|a| a.map { |n| n == num ? n = "x" : n }}
end

def check_row?(matrix)
  matrix.each do |a|
    return true if a.count("x") == 5
  end
  return false
end

def check_column?(matrix)
  check_row?(matrix.transpose)
end

# part 1 + 2 (inspired by Pierre to delete the win boards, much better now)
check_result = false
new_data = data
check_a.each do |num|
  break if check_result == true
  new_data = new_data.map{|matrix| mark_bingo(matrix, num)}
  new_data.each do |matrix|
    # break if check_result == true
      # binding.pry
    if check_row?(matrix) || check_column?(matrix)
      if new_data.size == data.size
        sum = matrix.flatten.select {|num| num != "x"}.sum
        p sum * num
        new_data.delete(matrix)
      elsif new_data.size == 1
        sum = matrix.flatten.select {|num| num != "x"}.sum
        p sum * num
        check_result = true
      else
        new_data.delete(matrix)
      end
    end
  end
end

# part 2
# def check_all_matrix(arr)
#   arr = arr.map do |matrix|
#     if check_row?(matrix) || check_column?(matrix)
#       matrix = true
#     else
#       matrix = false
#     end
#   end
#   arr
# end

# def result?(arr)
#   arr = check_all_matrix(arr)
#   arr.count(true) == arr.size - 1
# end

# check_result = false
# new_data = data
# index = nil
# check_a.each do |num|
#   break if check_result == true
#   new_data = new_data.map{|matrix| mark_bingo(matrix, num)}
#   if result?(new_data)
#     array = check_all_matrix(new_data)
#     index = array.index(false)
#   end
#   # binding.pry
#   if index != nil
#     if check_row?(new_data[index]) || check_column?(new_data[index])
#       check_result = true
#       final_data = new_data[index].flatten
#       final_data.delete(num)
#       p final_data.select {|num| num != "x"}.sum * num
#     end
#   end
# end
