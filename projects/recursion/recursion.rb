# require 'byebug'
def range(n1, n2)
  return [n1] if n1 + 1 == n2
  [n1].concat(range(n1 + 1, n2))
end

# p range(1, 5) # [1, 2, 3, 4]

def exponent1(base, power)
  return 1 if power == 0
  smaller_power = power - 1
  b * exponent1(base, smaller_power )
end

# p exponent1(2, 0) # 1
# p exponent1(9, 2) # 81

def exponent2(base, power)
  return 1 if power == 0
  smaller_power = power - 1
  if power.odd?
    base * (exponent2(base, smaller_power / 2)) * (exponent2(base, smaller_power / 2))
  else
    exponent2(base, power / 2) * exponent2(base, power / 2)
  end
end

# p exponent2(2, 0) # 1
# p exponent2(9, 2) # 81
# p exponent2(5, 1) # 5

def deep_dup( array )
  return array unless array.is_a?(Array)
  result = []
  array.each do |arr|
    result << deep_dup(arr)
  end

  result
end

# a = [1, [2], [3, [4]]]
# b = a.dup
# p b[2][1].object_id
# # p deep_dup(a)
# # a1 = [[1], 2, 3]
# # p deep_dup(a1)
# p deep_dup(a)
# v = deep_dup(a)
# p v[2][1].object_id
# p a[2][1].object_id

def fibonacci(n) #
  return [] if n == 0
  return [1] if n == 1
  return [1, 1] if n == 2
  last = fibonacci(n - 1)
  last.concat([last[-1] + last[-2]])
end

# p fibonacci(0)
# p fibonacci(2)
# p fibonacci(6)

def bsearch(array, target)
  return nil if !array.include?(target)
  pivot = array.length / 2
  left_side = array[0...pivot]
  right_side = array[pivot+1..-1]
  if target > array[pivot]
    left_side.length + 1 + bsearch(right_side, target)
  elsif target < array[pivot]
    bsearch(left_side, target)
  else
    pivot
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(arr)
  return [] if arr.length == 0
  return arr if arr.length == 1
  middle = arr.length / 2
  left_side = arr[0...middle] # exclude
  right_side = arr[middle..-1]
  merge(merge_sort(left_side), merge_sort(right_side))
end

def merge(left, right)
  # debugger
  lefty = left.dup
  righty = right.dup

  array = []
  until lefty.empty? || righty.empty?
    i = lefty.shift # first el
    j = righty.shift
    if i < j
      array << i
      righty.unshift(j)
    else
      array << j
      lefty.unshift(i)
    end
  end

  array.concat(lefty) unless lefty.empty?
  array.concat(righty) unless righty.empty?

  array
end

# p merge_sort([3, 45, 2, 8, 90]) # sorted

def subsets(array)
  return [[]] if array.empty?
  sub_sub_set = subsets(array[0...-1])
  sub_sub_set + sub_sub_set.map { |arr| arr + [array[-1]]}
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def permutations(array)
  return [array] if array.length <= 1
  last_perm = (permutations(array[0...-1]))
  result = []
  last_perm.each do |perm|
    (0..perm.length).each do |i|
      result << perm.drop(i) + [array[-1]] + perm.take(i)
    end
  end
  result
end

# p permutations([]) # [[]]
# p permutations([1]) # [[1]]
# p permutations([1, 2]) # [[1, 2], [2, 1]]
# p permutations([1, 2, 3])

def greedy_make_change(num, coins = [25, 10, 5, 1]) # 39 => [25, 10, 1, 1, 1, 1]

  if coins.length == 1
    return Array.new(num, coins[0])
  end
  coin = coins[0]
  results = []

  left_over = num % coin
  num_coins = num / coin

  num_coins.times do
    results << coin
  end
  results += greedy_make_change(left_over, coins[1..-1])
end

# p greedy_make_change(56)
# p greedy_make_change(24, [10, 7, 1])

def make_change(amt, coins = [25, 10, 5, 1])
  return 0 if amt == 0
  return nil if coins.empty?

  coins = coins.sort.reverse

  best_change = nil

  coins.each_with_index do |coin, i|
    next if coin > amt
    remainder = amt - coin

    best_remainder = make_change(remainder, coins.drop(i))
    next if best_remainder.nil?
    this_change = [coin] + best_remainder

    if best_change.nil? || best_remainder.nil?
    end 
  end
end



# def get_change(amt, coins=[25, 10, 5, 1])
#   #p "#{amt}, coins=#{coins}"
#   return Array.new(amt, coins[0]) if coins.length == 1
#   coin = coins[0]
#   max_num_coins = amt / coin
#
#   result = []
#   (1..max_num_coins).to_a.each do |n|
#     remainder = amt - (coin * n)
#     last = get_change(remainder, coins[1..-1])
#     change = Array.new(n, coin)
#     result << ([[change]+ last])
#   end
#   result
# end



a = get_change(24, [10, 7, 1])
p a
