puts 'Enter 1 number '
a = gets.chomp.to_f

puts 'Enter 2 number'
b = gets.chomp.to_f

puts 'Enter 3 number'
c = gets.chomp.to_f

d = b**2 - (4 * a * c)

if d > 0
  d = Math.sqrt(d)
  x1 = -b + d / 2 * a
  x2 = -b - d / 2 * a
  puts "Discriminant = #{d}; 1 st root #{x1}; 2 st root #{x2}"
elsif d == 0
  x1 = -(b / 2 * a)
  puts "Discriminant = #{d}; root #{x1}"
else d < 0
  puts "Discriminant = #{d}; no roots"
end
