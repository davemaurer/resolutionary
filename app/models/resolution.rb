class Resolution < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 115 }

  has_many :goals
  has_many :reminders
  belongs_to :user

  def self.completed
    where(finished: true)
  end

  def self.current
    where(finished: false)
  end

  def completed_goals
    self.goals.completed_goals
  end

  def current_goals
    self.goals.current_goals
  end
end
