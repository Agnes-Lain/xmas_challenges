# require 'json'
require "pry-byebug"

# filepath = 'beer.json'

# serialized_beers = File.read(filepath)

# beers = JSON.parse(serialized_beers)

# puts beers["beers"][0]['name']

def max_sequence(arr)
  #your code here
  return 0 if arr.length == 0
  memo_sum = arr[0]
  temp_sum = 0
  arr.each_with_index do | num, i |
    # binding.pry
    if i < arr.length - 1
      if (num + arr[i+1]) > 0
        temp_sum += num
        if temp_sum > memo_sum
          memo_sum = temp_sum
        end
      else
        temp_sum = 0
      end
    end
    puts "#{i} - #{num} - temp_sum: #{temp_sum} - memo_sum: #{memo_sum}"
  end
  return memo_sum
end


puts max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4])
