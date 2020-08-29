alphabet = ('a'..'z').to_a
list_vowels = ['a', 'e', 'i', 'o', 'u', 'y']
hash_vowels = {}

alphabet.each_with_index do |letter, index|
  hash_vowels[letter] = index + 1 if list_vowels.include?(letter)
end
