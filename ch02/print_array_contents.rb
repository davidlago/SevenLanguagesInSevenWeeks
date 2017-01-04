def print_groups_with_each(my_array, group_size)
  buffer = []
  my_array.each do |number|
    buffer << number
    if buffer.length == 4
      p buffer
      buffer = []
    end
  end
end

def print_groups_with_each_slice(my_array, group_size)
  my_array.each_slice(4) { |numbers| p numbers }
end

MY_ARRAY = (1..16).to_a # An array of numbers from 1 to 16
GROUP_SIZE = 4

puts "With each:"
print_groups_with_each(MY_ARRAY, GROUP_SIZE)

puts "\nWith each_slice:"
print_groups_with_each_slice(MY_ARRAY, GROUP_SIZE)
