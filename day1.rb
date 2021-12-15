def count_increasing(arr)
  prev = nil
  count = 0
  arr.each do |x|
    count += 1 if prev && x > prev
    prev = x
  end

  count
end

lines = $stdin.each_line.map(&:to_i)

# part 1
puts count_increasing(lines)

# part 2
windows = []
lines.each_with_index do |_, i|
  windows << lines[i..(i + 2)].sum if i + 2 < lines.length
end

puts count_increasing(windows)
