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

  # This method will rotate the cuboid. If the cuboid's rotation
  # is impeded, the rotation will not happenand the function will return
  # false. If the rotation occurs, the new vertices will be returned.
  # The rotation will be at 90 degree intervals.
  # Walls will be input as an array of other Cuboid objects.

  # The manner that this method checks for impediments is a good
  # approximation, but is not entirely accurate. This method simply
  # expands the cuboid about the axis it is being rotated by its scalar
  # distance from origin to appropriate vertex. It then checks to see if
  # there are now any intersections at this larger size.  If not, then
  # the box will be able to rotate smoothly.

  # In order to correct this approximation, I could convert the coords
  # of the box into spherical coordinates and call #intersection? at
  # each deg of rotation.
  def rotate(axis = :x, walls = [])

    # check to see if there are already impedements
    walls.each do |wall|
      return false if self.intersects?(wall)
    end

    case axis
    when :x
      if !walls.empty?
        dist = Math.sqrt((@h/2) ** 2 + (@w/2) ** 2)
        temp = Cuboid.new(@origin, @l, dist, dist)

        walls.each do |wall|
          return false if temp.intersects?(wall)
        end
      end

      rotate_x

    when :y
      if !walls.empty?
        dist = Math.sqrt((@l/2) ** 2 + (@w/2) ** 2)
        temp = Cuboid.new(@origin, dist, @h, dist)

        walls.each do |wall|
          return false if temp.intersects?(wall)
        end
      end

      rotate_y

    when :z
      if !walls.empty?
        dist = Math.sqrt((@h/2) ** 2 + (@l/2) ** 2)
        temp = Cuboid.new(@origin, dist, dist, @w)

        walls.each do |wall|
          return false if temp.intersects?(wall)
        end
      end

      rotate_z
    else
      raise ArgumentError, "Please use a symbol to identify the axis: :x, :y, or :z"
    end

    self.vertices
  end

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

  # helper methods to reassign vertices upon successful rotation
  def rotate_x
    @w, @h = @h, @w
  end

  def rotate_y
    @w, @l = @l, @w
  end

  def rotate_z
    @l, @w = @w, @l
  end

end
