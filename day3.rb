def shared_prefix_len(s1, s2)
  if s1.length == 0 || s2.length == 0 || s1[0] == s2[0]
    return 0
  end

  return 1 + shared_prefix_len(s1[1..], s2[1..])
end

def freqs(lines)
  raise RuntimeError, "empty array" if lines.empty?

  frequencies = Array.new(lines[0].length)

  lines.each do |line|
    line.each_with_index do |c, i|
      frequencies[i] ||= {"0" => 0, "1" => 0}
      frequencies[i][c] += 1
    end
  end

  frequencies
end

lines = $stdin.each_line.map do |line|
  line.strip.split("")
end.to_a

frequencies = freqs(lines)
gamma = frequencies.map do |x|
  if x["1"] >= x["0"]
    "1"
  else
    "0"
  end
end.join

epsilon = gamma.split("").map do |x|
  if x == "0"
    "1"
  else
    "0"
  end
end.join

# part 1
pp gamma.to_i(2) * epsilon.to_i(2)

def find_oxygen(lines, i = 0)
  raise "out of lines" if lines.empty?
  return lines.first if lines.length == 1

  fs = freqs(lines)
  lines = lines.select do |line|
    if fs[i]["1"] >= fs[i]["0"]
      line[i] == "1"
    else
      line[i] == "0"
    end
  end

  find_oxygen(lines, i + 1)
end

def find_co2(lines, i = 0)
  raise "out of lines" if lines.empty?
  return lines.first if lines.length == 1

  fs = freqs(lines)
  lines = lines.select do |line|
    if fs[i]["0"] <= fs[i]["1"]
      line[i] == "0"
    else
      line[i] == "1"
    end
  end

  find_co2(lines, i + 1)
end

oxygen = find_oxygen(lines).join
co2 = find_co2(lines).join

# part 2
pp oxygen.to_i(2) * co2.to_i(2)
