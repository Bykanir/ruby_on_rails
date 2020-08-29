products = {}

loop do
  puts "Enter product"
  product = gets.chomp.to_s

  break if product == "stop"

  puts "Enter price"
  price = gets.chomp.to_f

  puts "Enter amount product"
  amount = gets.chomp.to_f

  products[product] = { price: price, amount: amount }
end

total = 0

products.each do |product, info|
  puts "Total #{product} purchased - #{info[:total] = info[:price] * info[:amount]}"
  total += info[:total]
end

puts "The total value of all goods - #{total}"