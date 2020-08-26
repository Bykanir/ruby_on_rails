sides = []

puts 'Enter 1 side'
sides << gets.chomp.to_f

puts 'Enter 2 side'
sides << gets.chomp.to_f

puts 'Enter 3 side'
sides << gets.chomp.to_f

hypotenuse = sides[2]
cathet1 = sides[1]
cathet2 = sides[0]


if hypotenuse**2 == cathet1**2 + cathet2**2
  puts 'Right triangle'
else
  puts 'Triangle if not rectangular'
end

if hypotenuse == cathet1 or hypotenuse == cathet2 or cathet1 == cathet2
  puts 'Isosceles triangle'
end

if  hypotenuse == cathet1 and cathet1 == cathet2
  puts 'Equilateral triangle'
end
