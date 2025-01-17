require 'rails_helper'

describe Astronaut, type: :model do
  before :each do
    @astronaut1 = Astronaut.create(name: "Niel Armstring", age: 37, job: "Commander")
    @astronaut2 = Astronaut.create(name: "Niel degrass tyson", age: 42, job: "Astrophysist")
    @astronaut3 = Astronaut.create(name: "Mom", age: 57, job: "Interplanetary Biology")
    @astronaut4 = Astronaut.create(name: "Dad", age: 62, job: "Computer Science")

    @apollo14 = Mission.create(title: "Apollo 14", time_in_space: 123)
    @capricorn4 = Mission.create(title: "Capricorn 4", time_in_space: 453 )
    @gemini7 = Mission.create(title: "Gemini 7", time_in_space: 777)
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  it "Calculates the average age of all Astronauts" do
    expect(Astronaut.average_age).to eq("49.5 Years")
  end

  it "Will return the missions in alphabetical order" do
    expect(Astronaut.current_missions).to eq(["Apollo 14", "Capricorn 4", "Gemini 7"])
  end

  it "Will return the amount of time that an astronaut is in space" do
    @astronaut1.missions << @apollo14
    expect(@astronaut1.time_in_space).to eq(@apollo14.time_in_space)
    
    @astronaut1.missions << @capricorn4
    expect(@astronaut1.time_in_space).to eq(@apollo14.time_in_space + @capricorn4.time_in_space)
    
    @astronaut2.missions << @gemini7
    expect(@astronaut2.time_in_space).to eq(@gemini7.time_in_space)
    
    expect(@astronaut3.time_in_space).to eq(0)
    expect(@astronaut4.time_in_space).to eq(0)
  end

  it 'Will add missions based on search' do
    expect(@astronaut1.missions).to eq([])
    @astronaut1.missions << @apollo14
    expect(@astronaut1.missions).to eq([@apollo14])

    expect(@astronaut1.add_mission(@capricorn4)).to eq([@apollo14, @capricorn4])


    expect(@astronaut4.missions).to eq([])
    @astronaut4.add_mission(@apollo14)
    @astronaut4.add_mission(@capricorn4)
    @astronaut4.add_mission(@gemini7)
    expect(@astronaut4.missions).to eq([@apollo14, @capricorn4, @gemini7])
  end
end
