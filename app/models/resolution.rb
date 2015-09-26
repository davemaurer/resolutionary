class Resolution < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 140 }

  has_many :goals
  belongs_to :user
end
