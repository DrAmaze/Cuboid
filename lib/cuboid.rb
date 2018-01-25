
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

  # Reassigns origin of cuboid. Returns new origin.
  def move_to!(x, y, z)
    @origin = [x, y, z]
  end

  # calculates and returns an array of the eight vertices
  # Each vertex is given as (x, y, z)
  def vertices
    vertices = []

    vertices << [(@origin[0] + @l/2.0), (@origin[1] + @h/2.0), (@origin[2] + @w/2.0)]
    vertices << [(@origin[0] + @l/2.0), (@origin[1] + @h/2.0), (@origin[2] - @w/2.0)]
    vertices << [(@origin[0] + @l/2.0), (@origin[1] - @h/2.0), (@origin[2] - @w/2.0)]
    vertices << [(@origin[0] + @l/2.0), (@origin[1] - @h/2.0), (@origin[2] + @w/2.0)]
    vertices << [(@origin[0] - @l/2.0), (@origin[1] - @h/2.0), (@origin[2] + @w/2.0)]
    vertices << [(@origin[0] - @l/2.0), (@origin[1] - @h/2.0), (@origin[2] - @w/2.0)]
    vertices << [(@origin[0] - @l/2.0), (@origin[1] + @h/2.0), (@origin[2] - @w/2.0)]
    vertices << [(@origin[0] - @l/2.0), (@origin[1] + @h/2.0), (@origin[2] + @w/2.0)]

    vertices
  end

  # Returns true if the two cuboids intersect each other.
  # False otherwise. If one cuboid is within another, that counts as
  # an intersection.
  # This checks each dimension to ensure that there is at least one
  # point that overlaps in the (x, y, z) plane.
  def intersects?(other)
    self_index = dimensions(self.vertices)
    other_index = dimensions(other.vertices)

    intersection = {}
    intersection[:x] = self_index[:x] & other_index[:x]
    intersection[:y] = self_index[:y] & other_index[:y]
    intersection[:z] = self_index[:z] & other_index[:z]

    intersection.value?([]) ? false : true
  end

  #END public methods that should be your starting point

  private

  # Outputs incremented ranges for length, height, and width of a cuboid.
  # This will be used in calculation to determine if cuboids intersect.
  # The incrementor used is .01 so as to ensure accuracy, but not
  # decreases the speed of the program.  For greater accuracy, the
  # incrementor would be smaller.  For greater speed, the incrementor
  # would be larger
  def dimensions(vertices)

    dims = { x: [], y: [], z: [] }

    # length or x-axis
    if vertices[0][0] < vertices[-1][0]
      (vertices[0][0]..vertices[-1][0]).step(0.01) { |n| dims[:x] << n }
    else
      (vertices[-1][0]..vertices[0][0]).step(0.01) { |n| dims[:x] << n }
    end

    # height or y-axis
    if vertices[0][1] < vertices[3][1]
      (vertices[0][1]..vertices[3][1]).step(0.01) { |n| dims[:y] << n }
    else
      (vertices[3][1]..vertices[0][1]).step(0.01) { |n| dims[:y] << n }
    end

    # width or z-axis
    if vertices[0][2] < vertices[1][2]
      (vertices[0][2]..vertices[1][2]).step(0.01) { |n| dims[:z] << n }
    else
      (vertices[1][2]..vertices[0][2]).step(0.01) { |n| dims[:z] << n }
    end

    dims
  end
end
