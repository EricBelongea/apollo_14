require "rails_helper"

RSpec.describe Astronaut do
  before :each do
    @astronaut1 = Astronaut.create(name: "Niel Armstring", age: 37, job: "Commander")
    @astronaut2 = Astronaut.create(name: "Niel degrass tyson", age: 42, job: "Astrophysist")
    @astronaut3 = Astronaut.create(name: "Mom", age: 57, job: "Interplanetary Biology")
    @astronaut4 = Astronaut.create(name: "Dad", age: 62, job: "Computer Science")

  end

  it 'Visiting the index page with show all of an astronauts attributes' do
    visit "/astronauts"

    expect(page).to have_content(@astronaut1.name)
    expect(page).to have_content(@astronaut1.age)
    expect(page).to have_content(@astronaut1.job)
  end

  it "Shows average age of astronauts" do
    visit "/astronauts"

    expect(page).to have_content("Average Astro Age: #{Astronaut.average(:age)} Years")
  end
end