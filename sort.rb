
# Build your own sort method. It does not have to be fancy, any sort will do.
# There are many listed here: http://en.wikipedia.org/wiki/Sorting_algorithm#Summaries_of_popular_sorting_algorithms
# insertion sort or selection sort are probably easiest

# The purpose is to let the user customize how you sort the array by submitting a block that tells you which
# element goes first.
#
# If a block is given , it should use the block to determine what order the elements should be sorted by
# 
# Rules for spaceship operator (Java calls it compareTo):
#   given two elements, the proc should return -1 if the first element goes first
#   it should return 1 if the second argument goes first
#   it should return 0 if it doesn't matter which order the elements go
#
# if no block is given, use the spaceship operator <=> to determine it
#
# EXTRA POINTS FOR:
#   normalizing the input (the proc) at the start, rather than checking to see if it is there every time
#   you wish to use it. (hint: if no block is submitted, the proc variable will be nil)
#
#
# EXAMPLE: 
#
# sorting numbers:
#
# your_sort [24, 0, 68, 44, 68, 47, 42, 66, 89, 22]             # => [0, 22, 24, 42, 44, 47, 66, 68, 68, 89]
#
# your_sort [24, 0, 68, 44, 68, 47, 42, 66, 89, 22] do |a,b|
#   if a < b
#     -1
#   elsif a > b
#     1
#   else
#     0
#   end
# end   # => [0, 22, 24, 42, 44, 47, 66, 68, 68, 89]
#
# 
# sorted by second letter (don't worry about things like 'the' vs 'The'):
# your_sort %w(The quick brown fox jumps over the lazy dog) do |a,b|
#   a[1..1] <=> b[1..1]
# end   # => ["lazy", "The", "the", "fox", "dog", "brown", "jumps", "quick", "over"]
#
# 
# placing all strings first, integers second, and floats last, each sorted within themselves
# your_sort [ 2.5 , 'r' , 1 , 4 , 'a' , 9 , 3 , 9.0 , 'm' , 25.8 ] do |a,b|
#   a_class_val = [ String , Fixnum , Float ].index a.class
#   b_class_val = [ String , Fixnum , Float ].index b.class
#   if a_class_val == b_class_val
#     a <=> b
#   else
#     a_class_val <=> b_class_val
#   end
# end       # => ["a", "m", "r", 1, 3, 4, 9, 2.5, 9.0, 25.8]

require 'debugger'

def your_sort(array_tobe_sorted)
	index = 0
	insertion_index = 1
	nu_array = []
	if block_given?
		if array_tobe_sorted.all? {|type| type.class == String}
			while index < array_tobe_sorted.length
				#Insertion sort
				insertion_index = index + 1

				while insertion_index < array_tobe_sorted.length
					if insertion_index != index
						result = yield array_tobe_sorted[index], array_tobe_sorted[insertion_index]
					else
						result = -1
					end
						
					if result == 1 
						# Insertion sort	
						nu_value = array_tobe_sorted.delete_at(insertion_index)	
						array_tobe_sorted.insert(index,nu_value)						
					end
					insertion_index += 1
				end
				index += 1
			end
			return array_tobe_sorted

		else
			string_array = []
			int_array = []
			float_array = []

			string_array = array_tobe_sorted.select { |value| value.class == String}
			int_array = array_tobe_sorted.select { |value| value.class == Fixnum}
			float_array = array_tobe_sorted.select { |value| value.class == Float}
			return string_array.sort + int_array.sort + float_array.sort

		end



	end

	array_tobe_sorted.sort
end

