require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do

  subject { Cuboid.new([0,0,0], 5, 5, 5) }
  let(:other_subject) { Cuboid.new([1,1,1], 1, 1, 1)}
  let(:cuboid) { Cuboid.new([3, 3, 3], 1, 5, 2)}

  describe "#initialize" do
    it "instantiates the cuboid at random origin" do
      cube = Cuboid.new(1, 1, 1)
      expect(cube).to be_instance_of(Cuboid)
    end

    it "raises argument error if dimensions are less than or equal to 0" do
      expect{ Cuboid.new(0, -2, -3) }.to raise_error(ArgumentError, 'length, width, and height must be nonzero, positive number')
    end
  end

  describe "#move_to" do
    it "changes the origin in the simple happy case" do
      expect(subject.move_to!(1,2,3)).to eq([1, 2, 3])
    end
  end

  describe "#vertices" do
    it "returns an array of eight vertices" do
      expect(subject.vertices.length).to be 8
    end

    it "calculates the vertices based on the origin" do
      subject_vertices = subject.vertices
      other_subject_vertices = other_subject.vertices

      expect(subject_vertices).to_not eq(other_subject_vertices)
    end

    it "updates the vertices when the origin is relocated" do
      vertices = subject.vertices
      subject.move_to!(8, 8, 8)
      new_vertices = subject.vertices
      expect(vertices).to_not eq(new_vertices)
    end
  end

  describe "#intersects?" do
    it "returns false if two cuboids do not intersect each other" do
      cube = Cuboid.new([10, 10, 10], 1, 2, 3)
      expect(subject.intersects?(cube)).to be false
    end

    it "returns true if one cuboid is inside another" do
      cube = Cuboid.new([1, 1, 1], 0.5, 0.5, 0.5)
      expect(subject.intersects?(cube)).to be true
    end

    it "returns true if two cuboids share a single point" do
      cube = Cuboid.new([3, 3, 3], 1, 1, 1)
      expect(subject.intersects?(cube)).to be true
    end
  end

  describe "#rotate" do
    it "raises an error if an invalid axis is input" do
      expect{ subject.rotate("i", []) }.to raise_error(ArgumentError, "Please use a symbol to identify the axis: :x, :y, or :z")
    end

    it "rotates subject successfully when no walls are given" do
      original_vertices = cuboid.vertices
      cuboid.rotate
      expect(cuboid.vertices).to_not eq(original_vertices)
    end

    it "successfully rotates when non-impeding walls are given" do
      original_vertices = cuboid.vertices
      cuboid.rotate(:y, [other_subject])
      expect(cuboid.vertices).to_not eq(original_vertices)
    end

    it "does not rotate when impeded by a wall that did not original intersect with the cuboid" do
      wall = Cuboid.new([3, 0, 0], 0.3, 5, 5)

      expect(subject.rotate(:x, [wall])).to be false
    end

    it "does not rotate if, prior to rotation, the cuboid already intersects with a wall" do
      expect(subject.rotate(:x, [other_subject])).to be false
    end
  end


end
