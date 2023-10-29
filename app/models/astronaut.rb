class Astronaut < ApplicationRecord
  validates_presence_of :name, :age, :job
  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  def self.average_age
    "#{average(:age)} Years"
  end

  def self.current_missions
    Mission.order(title: :asc).pluck(:title)
  end

  def time_in_space
    time = 0
    missions.each do |mission|
      time += mission.time_in_space
    end
    time
  end

  def add_mission(mission_id)
    missions << Mission.find_by(id: mission_id)
  end
end
