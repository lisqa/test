=begin 
Заполнить массив числами фибоначчи до 100
=end

arr = [0, 1]
i = 1
while arr[-1] <= 100 
	arr << (arr[i-1] + arr [i])
	i += 1
end
arr.delete_at(-1)
