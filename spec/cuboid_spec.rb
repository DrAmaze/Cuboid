require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do

  subject { Cuboid.new([0,0,0], 5, 5, 5) }
  let(:other_subject) { Cuboid.new([1,1,1], 1, 1, 1)}

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

  describe "intersects?" do
  end

end
