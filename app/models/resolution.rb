class Resolution < ActiveRecord::Base
  has_many :goals
  belongs_to :user
end
