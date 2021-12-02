require 'csv'

filepath = 'data_day2.csv'

data = CSV.read(filepath)
hash_d = {}
data.each do |d|
  arr = d[0].split(" ")
  k = arr[0]
  v = arr[1].to_i
  hash_d[k] ? hash_d[k] += v : hash_d[k] = v
end

puts hash_d

result = hash_d["forward"] * (hash_d["down"] - hash_d["up"])

puts result


# down X increases your aim by X units.
# up X decreases your aim by X units.
# forward X does two things:
# It increases your horizontal position by X units.
# It increases your depth by your aim multiplied by X.
deepth = 0
aim = 0
distance = 0
data.each do |d|
  arr = d[0].split(" ")
  k = arr[0]
  v = arr[1].to_i
  if k == "forward"
    distance += v
    deepth += v*aim
  elsif k == "down"
    aim += v
  else
    aim -= v
  end
end

puts deepth * distance
