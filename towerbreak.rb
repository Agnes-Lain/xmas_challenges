require "pry-byebug"

def towerBreakers(n, m)
    # Write your code here
    turn = 0
    choice = 0
    towers = Array.new(n, m)
    target = towers.max
    binding.pry
    while target > 1
      (1...target).to_a.each do |num|
        if n == 1
            towers[0] = 1
            break
        elsif target % (target-num) ==0
            choice = num
            index = towers.index(target)
            towers[index] = target - num
            break
        end
      end
      turn += 1
      target = towers.max
    end
    turn.even? ? 2 : 1
end

towerBreakers(3, 7)
