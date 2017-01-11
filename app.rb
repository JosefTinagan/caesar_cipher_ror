require 'sinatra'
#if development? require 'sinatra/reloader'


get "/" do 
	@word = params["word"]
	@shift = params["shift"]

	@ciphered_word = Cipher.new.caesar_cipher(@word.to_s,@shift.to_i)
	erb :index
end

class Cipher
	def initialize
		@arr = (97.chr..122.chr).to_a
	end

	def caesar_cipher(word,shift=0)
		return nil if word == ""
		word = word.split("")
		x = 0
		result_string = ""
		while word.length > x 
			has_space = space_check?(word,x)
			if(has_space)
				result_string += word[x]
				x += 1
			else
				word[x], capital = upcase?(word,x)
				y = find_letter(word,x)
				temp = shifting(y,shift)
				temp = capital?(temp,capital)
				result_string += temp
				x += 1
			end	
		end
		return result_string
	end

	def shifting(y,shift)
		val_test = y + shift
			if(val_test > @arr.length-1)
				val = val_test % @arr.length
				temp = @arr[val]
			else
				temp = @arr[y+shift]
			end
		return temp
	end

	def find_letter(word,x)
		y = 0
		while word[x] != @arr[y]
					y += 1
		end
		return y
	end

	def space_check?(word,x)
		if(word[x] =~ /\W/ )
			has_space = true
		else
			has_space = false
		end
		return has_space
	end

	def capital?(temp,capital)
		if capital
			temp = temp.upcase
		else
			temp = temp
		end
		return temp
	end

	def upcase?(word,x)
		capital = false
		if(word[x] == word[x].upcase)
			word[x].downcase!
			capital = true
		end
		return word[x], capital
	end
end