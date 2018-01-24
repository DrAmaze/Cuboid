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

  describe "intersects?" do
  end

end
