class Knight
  attr_reader :start

  def initialize(start, finish)
    @start = start
    @finish = finish
    @root = Move.new(@start)
    @visited = [@start]
    find_route_to_finish(@root)
  end

  def find_route_to_finish(current)
    route = build_move_list(current)
    output_route(route)
  end

  def build_move_list(current)
    queue = [current]
    until current.square == @finish
      current = queue[0]
      find_children(current)
      current.children.each do |child|
        new_move = Move.new(child)
        new_move.parent = current
        queue << new_move
      end
      queue.shift
    end
  return current
  end

  def output_route(route)
    count = 0
    reversed = []
    puts "Here is your route: \n#{@start}"
    until route.parent.nil?
      count += 1
      reversed << route.square
      route = route.parent
    end
    reversed.reverse!
    reversed.each { |sq| puts "#{sq}"}
    puts "You made it in #{count} moves."
  end

  def find_children(current)
    directions = [[2,1], [-2,1], [2,-1], [-2,-1], [1,2], [-1,2], [1,-2], [-1,-2]]
    directions.each do |direction|
      move = [current.square[0] + direction[0], current.square[1] + direction[1]]
      current.children << move if move[0].between?(1,8) && move[1].between?(1,8) && !@visited.include?(move)
      @visited << move unless @visited.include?(move)
    end
  end
end

class Move
  attr_reader :square
  attr_accessor :children, :parent

  def initialize(square, parent = nil)
    @square = square
    @children = []
    @parent = parent
  end
end
