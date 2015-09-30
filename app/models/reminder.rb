class Reminder < ActiveRecord::Base
  validates :phone_number, presence: true

  belongs_to :resolution

  after_create :remind

  def remind
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    reminder = "Hi #{recipient.name}. You made a resolution to #{resolution.title}. Get on it!"
    @client.account.messages.create(
                            from: @twilio_number,
                            to: self.phone_number,
                            body: reminder
                            )
  end

  private

  def resolution
    @resolution ||= Resolution.find_by(id: resolution_id)
  end

  def recipient
    User.find(resolution[:user_id])
  end
end
