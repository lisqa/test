=begin 
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
aeiouy
=end

arr_alphabet = ("a".."z").to_a
alphabet = {} 
(0..25).each { |i| alphabet[arr_alphabet[i]] = (i + 1) }
arr_vowels = ["a", "e", "i", "o", "u", "y"] 
vowels = {}
vowels = alphabet.select { |key, value| arr_vowels.include?(key) }
