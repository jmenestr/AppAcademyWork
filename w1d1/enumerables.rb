require 'byebug'

class Array
  def my_each
   i = 0
   while i < self.length
     yield self[i]
     i+=1
   end
   return self
  end

  def my_select
    new_ary = []
    self.my_each do |el|
      new_ary << el if yield(el)
    end
    new_ary
  end

  def my_reject
    new_ary = []
    self.my_each do |el|
      new_ary << el unless yield(el)
    end
    new_ary
  end

  def my_any?
    self.my_each do |el|
      return true if yield(el)
    end
    return false
  end

  def my_all?
    self.my_each do |el|
      return false unless yield(el)
    end
    return true

  end

  def my_flatten(ary = [])
    self.my_each do |el|
      if el.is_a?(Array)
        el.my_flatten(ary)
      else
        ary << el
      end
    end
    ary
  end

  def my_zip(*args)
    new_array = []
    (0...self.length).each do |i|
      arr = []
      arr << self[i]
      args.each do |el|
        arr << el[i]
      end
      new_array << arr
    end
    return new_array
  end

  def my_rotate!(rot = 1)
    pstv = (rot > 0) ? true : false
    rot = rot.abs
    rot = (rot > self.length) ? self.length % rot : rot
    #byebug
    if pstv
      front = self.shift(rot)

      new_ary = self + front
    else
      back = self.pop(rot)
      new_ary = back + self
    end
    new_ary
  end

  def my_join(sep = "")
    new_str = ""
    (0...self.length).to_a.my_each do |indx|
      new_str << self[indx]
      new_str << sep unless indx == self.length - 1
    end
    new_str
  end

  def my_reverse
    return self if length == 1
    i = self.length - 1
    new_array = []
    while i >= 0
      new_array << self[i]
      i -= 1
    end
    new_array
  end

end



#[1,2,3].my_each {|num| puts num }
p [1,2,3,4].my_select {|num| num.even?}
p [1,2,3,4].my_reject {|num| num.even?}
a = [1, 2, 3]
b = [4, 5, 6]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true
p a.my_zip(b)


a = ["a","b","c"]
print a.my_reverse
