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
end
