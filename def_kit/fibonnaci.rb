def fibonacci(input, reversal: true)
  sequence = Array.new(input)
  sequence[0] = 0
  sequence[1] = 1
  (2..(input-1)).each do |num|
    sequence[num] = sequence[num-2] + sequence[num-1]
  end
  return sequence.reverse! if reversal
  sequence
end

# puts automatically appends a new line, print doesn't.
print fibonacci(8, reversal: false)
puts 