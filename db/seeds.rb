# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

astronaut1 = Astronaut.create(name: "Niel Armstring", age: 37, job: "Commander")
astronaut2 = Astronaut.create(name: "Niel degrass tyson", age: 42, job: "Astrophysist")
astronaut3 = Astronaut.create(name: "Mom", age: 57, job: "Interplanetary Biology")
astronaut4 = Astronaut.create(name: "Dad", age: 62, job: "Computer Science")

apollo14 = Mission.create(title: "Apollo 14", time_in_space: 123)
capricorn4 = Mission.create(title: "Capricorn 4", time_in_space: 453 )
gemini7 = Mission.create(title: "Gemini 7", time_in_space: 777)

astronaut1.missions << apollo14
astronaut1.missions << capricorn4
astronaut2.missions << gemini7
