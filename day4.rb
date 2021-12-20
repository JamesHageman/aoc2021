require 'set'

def assert(expr)
    if !expr
        raise "assertion failed"
    end
end

lines = $stdin.each_line.map(&:strip).to_a

draw = lines[0].split(",").map(&:to_i)

boards = []
lines = lines[1..]

while lines.length > 0
    board = lines[1..5].map do |line|
        line.split(" ").map(&:to_i)
    end

    boards << board
    lines = lines[6..]
end

# 39 31 13  2 38
# 60 65 18  7  1
# 74 23 78 51  4
# 50 61 83 94 25
# 34  3 80  6 87

# inverts a board
def cols(board)
    cols = Array.new(5)
    (0...5).each do |y|
        (0...5).each do |x|
            cols[x] ||= Array.new(5)
            cols[x][y] = board[y][x]
        end
    end

    cols
end

def matches_row(board, draw)
    board.any? { |row| Set.new(row) <= draw }
end

def matches_col(board, draw)
    matches_row(cols(board), draw)
end

_b = [
    [78, 11, 12, 58, 61],
    [26, 8, 51, 28, 69],
    [64, 35, 89, 95, 1],
    [20, 79, 62, 13, 83],
    [53, 7, 84, 18, 34],
]

pp _b, cols(_b)
pp matches_col(_b, Set.new([58, 28, 95, 13, 18]))
pp matches_col(_b, Set.new([11, 8, 35, 79, 7]))

def matches(board, draw)
    if matches_row(board, draw)
        # pp "matches row", board, draw
        true
    elsif matches_col(board, draw)
        # pp "matches col", board, draw
        true
    else
        false
    end
end

def sum(board, draw)
    board.sum do |row|
        (Set.new(row) - draw).sum
    end
end

set = Set.new(draw[0...5])
winner = nil
while set.length < draw.length
    # pp set
    winner = boards.find { |b| matches(b, set) }
    break unless winner.nil?

    set.add(draw[set.length])
end

raise "no winner" if winner.nil?

last_called = draw[set.length - 1]
s = sum(board, set)

# part 1
pp(winner)
puts(set.to_s)
pp(s, last_called)
pp(s * last_called)
