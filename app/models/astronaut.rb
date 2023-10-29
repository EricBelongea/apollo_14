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
end
