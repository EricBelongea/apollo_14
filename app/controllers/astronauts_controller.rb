class AstronautsController < ApplicationController
  def index 
    @astronauts = Astronaut.all
    @age = Astronaut.average_age
  end
end