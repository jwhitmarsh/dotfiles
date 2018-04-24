require 'securerandom'

length = (ARGV[0] || 15).to_i

NUMBERS = (0..9).to_a
UPPERCASE_LETTERS = ('A'..'Z').to_a
LOWERCASE_LETTERS = ('a'..'z').to_a
SYMBOLS = %w(+ - ^ ! ? & @ \\)
CHARS = NUMBERS + UPPERCASE_LETTERS + LOWERCASE_LETTERS + SYMBOLS

def random_character
  random_index = SecureRandom.random_number(CHARS.length)
  CHARS[random_index].to_s
end

result = length.times.inject('') do |result|
  result += random_character
end

puts result
