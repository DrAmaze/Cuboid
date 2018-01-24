
class Cuboid

  # Only allow observer to see vertices, as the other
  # dimensions are found with arithmetic. It is important to only supply
  # the user with the information they need.
  attr_reader :vertices

  # instantiates a cuboid with its origin and its dimensions
  # origin = [length, height, width]
  # length ~ x
  # height ~ y
  # width ~ z
  def initialize(origin = [rand(10) - 5, rand(10) - 5, rand(10) - 5], length, width, height)
    if length <= 0 || height <= 0 || width <= 0
      raise ArgumentError, 'length, width, and height must be nonzero, positive number'
    end

    @origin = origin
    @l = length
    @h = height
    @w = width
  end

  #BEGIN public methods that should be your starting point

  def move_to!(x, y, z)
  end

  def vertices
  end

  #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other)
  end

  #END public methods that should be your starting point
end
