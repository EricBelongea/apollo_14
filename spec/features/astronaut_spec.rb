require "rails_helper"

RSpec.describe Astronaut do
  before :each do
    @astronaut1 = Astronaut.create(name: "Niel Armstring", age: 37, job: "Commander")
    @astronaut2 = Astronaut.create(name: "Niel degrass tyson", age: 42, job: "Astrophysist")
    @astronaut3 = Astronaut.create(name: "Mom", age: 57, job: "Interplanetary Biology")
    @astronaut4 = Astronaut.create(name: "Dad", age: 62, job: "Computer Science")

    @apollo14 = Mission.create(title: "Apollo 14", time_in_space: 123)
    @capricorn4 = Mission.create(title: "Capricorn 4", time_in_space: 453 )
    @gemini7 = Mission.create(title: "Gemini 7", time_in_space: 777)
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

  it 'Shows all missions in alphabetical order' do
    visit "/astronauts"

    expect("Apollo 14").to appear_before("Capricorn 4")
    expect("Capricorn 4").to appear_before("Gemini 7")
  end

  it "Will show astronaut time in space" do
    @astronaut1.missions << @apollo14

    visit "/astronauts"

    expect(page).to have_content("#{@astronaut1.name} #{@astronaut1.age} #{@astronaut1.job} #{@astronaut1.time_in_space}")
    # Two ways
    # expect(page).to have_content("Niel Armstring 37 Commander 123 Days")
  end

  # Extensions

  it "Will create a show page for name and missions" do
    @astronaut1.missions << @apollo14
    @astronaut1.missions << @capricorn4

    visit "/astronauts/#{@astronaut1.id}"

    expect(page).to have_content("#{@astronaut1.name}")
    expect(page).to have_content("Missions:")
    
    within("div#missions") do
      expect(page).to have_content("#{@apollo14.title}")
      expect(page).to have_content("#{@capricorn4.title}")
    end
    

    @astronaut2.missions << @gemini7

    visit "/astronauts/#{@astronaut2.id}"

    expect(page).to have_content("#{@astronaut2.name}")

    within("div#missions") do
      expect(page).to have_content(@gemini7.title)
    end
  end

  it "can add missions to astronauts" do
    visit "/astronauts/#{@astronaut4.id}"

    expect(page).to have_content(@astronaut4.name)
    expect(@astronaut4.missions).to eq([])
    expect(page).to have_content("Missions:")
    expect(page).to_not have_content("#{@apollo14.title}")
    expect(page).to_not have_content("#{@capricorn4.title}")
    expect(page).to_not have_content("#{@gemini7.title}")

    expect(page).to have_content("Enter mission id")
    expect(page).to have_button("Add Mission")

    fill_in(:added_mission, with: "#{@apollo14.id}")
    # save_and_open_page
    expect(page).to_not have_content("#{@apollo14.title}")
    click_button("Add Mission")

    expect(current_path).to eq("/astronauts/#{@astronaut4.id}")
    expect(page).to have_content("#{@apollo14.title}")
  end
end