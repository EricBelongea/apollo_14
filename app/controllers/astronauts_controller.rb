class AstronautsController < ApplicationController
  def index 
    @astronauts = Astronaut.all
  end

  def show
    @astronaut = Astronaut.find(params[:id])
    if params[:added_mission] != nil
      @astronaut.add_mission(params[:added_mission])
    end
  end
end