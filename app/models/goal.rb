class Goal < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :resolution

  def self.completed_goals
    where(completed: true)
  end

  def self.current_goals
    where(completed: false)
  end
end
