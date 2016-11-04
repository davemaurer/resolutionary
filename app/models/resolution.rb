class Resolution < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 115 }

  has_many :goals, dependent: :destroy
  has_many :reminders, dependent: :destroy
  belongs_to :user

  FORGOTTEN_THRESHOLD = 30.days.ago
  def self.completed
    where(finished: true)
  end

  def self.current
    where(finished: false)
  end

  def self.forgotten
    empty_old_resolutions | resolutions_with_only_inactive_goals
  end

  def self.empty_old_resolutions
    where("updated_at < '#{FORGOTTEN_THRESHOLD}'")
  end

  def self.resolutions_with_only_inactive_goals
    Resolution
      .joins(:goals)
      .where("goals.updated_at < '#{FORGOTTEN_THRESHOLD}'")
  end

  def completed_goals
    self.goals.completed_goals
  end

  def current_goals
    self.goals.current_goals
  end
end
