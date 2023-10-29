class AstronautsController < ApplicationController
  def index 
    @astronauts = Astronaut.all
    @age = Astronaut.average_age
    @missions = Astronaut.current_missions
  end
end