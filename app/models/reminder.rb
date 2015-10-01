class Reminder < ActiveRecord::Base
  validates :phone_number, presence: true

  belongs_to :resolution

  after_create :remind

  def remind
    TwilioService.twilio_client(resolution, recipient, self.phone_number)
  end

  private

  def resolution
    @resolution ||= Resolution.find_by(id: resolution_id)
  end

  def recipient
    User.find(resolution[:user_id])
  end
end
