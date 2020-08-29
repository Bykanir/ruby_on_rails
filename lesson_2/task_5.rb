months = [31, 28,  31, 30,  31,  30,  31, 31, 30, 31, 30, 31]


puts 'Enter day'
day = gets.chomp.to_i

puts 'Enter month'
month = gets.chomp.to_i

puts 'Enter year'
year = gets.chomp.to_i

months[1] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0

month == 1 ? num = day : num = months[0..(month-2)].inject(:+) + day

puts "Day serial number #{num}"
