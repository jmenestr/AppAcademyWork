# We're going to implement a cipher called the Folding Cipher. Why? Because it
# folds the alphabet in half and uses the adjacent letter.
#
# For example,
# a <=> z
# b <=> y
# c <=> x
# ...
# m <=> n
#
# Hint: Think about zipping some things together.

def folding_cipher(str)
  alpha = ("a".."z").to_a
  alpha_first13 = alpha.first(13)
  alpha_last13 = alpha.last(13).reverse

  first_to_last = alpha_first13.zip(alpha_last13).to_h
  last_to_first = alpha_last13.zip(alpha_first13).to_h

  folded_str = str.split("").map do |ch|
    if first_to_last.keys.include?(ch)
      first_to_last[ch]
    elsif last_to_first.keys.include?(ch)
      last_to_first[ch]
    end
  end

  folded_str.join("")
end

# Write a method that returns the factors of a number
def factors(num)

  factors = []
  n = 1
  while n < num+1
    factors << n if num % n == 0
    n += 1
  end
  factors
end

# Jumble sort will take a string and return a string with the letters ordered
# according to the order of an alphabet array that will be handed to the method.
# If no alphabet array is provided, it should default to alphabetical order.

def jumble_sort(str, alphabet = nil)
  sort_hash = {}
  if alphabet.nil?
       ("a".."z").to_a.each_with_index { |el,i| sort_hash[el] = i}
  else
     alphabet.each_with_index {|char,i| sort_hash[char] = i }
  end

    sorted = str.split("").sort {|char1, char2| sort_hash[char1] <=> sort_hash[char2] }
    sorted.join("")
end

class Array
  # Write an array method that returns `true` if the array has duplicated
  # values and `false` if it does not
  def dups
    self.length != self.uniq.length
  end
end

# Determine if a string is symmetrical. 'racecar' and
# 'too hot to hoot' are examples of symmetrical strings.
# You are NOT permitted to use Array#reverse,
# Array#reverse!, String#reverse, or String#reverse!
class String
  def symmetrical?
    rev_str = ""
    str_cpy = self.gsub(" ","")
    str_cpy.each_char {|char| rev_str = char + rev_str}
    puts rev_str
    str_cpy == rev_str
  end
end
