puts 'What is your name?'
name = gets.chomp

puts 'What your height?'
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15

puts "Your ideal weight - #{ideal_weight}"

puts "#{name}, your weight is already optimal" if ideal_weight < 0