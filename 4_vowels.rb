=begin 
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
aeiouy
=end

arr_alphabet = []
("a".."z").each { |i| arr_alphabet << i }
alphabet = Hash.new 
for i in 0..25
	alphabet[arr_alphabet[i]] = (i + 1)
end

arr_vowels = ["a", "e", "i", "o", "u", "y"] 
vowels = Hash.new
vowels = alphabet.select { |key, value| arr_vowels.include?(key) }
