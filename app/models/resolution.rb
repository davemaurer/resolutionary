class Resolution < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 115 }

  has_many :goals
  belongs_to :user

  def self.completed
    where(finished: true)
  end

  def self.current
    where(finished: false)
  end
end
