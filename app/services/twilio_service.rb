class TwilioService
  def self.twilio_client(resolution, recipient, phone_number)
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    reminder = "Hi #{recipient.name}. You made a resolution: #{resolution.title}. Get on it!"
    @client.account.messages.create(
      from: @twilio_number,
      to: phone_number,
      body: reminder
    )
  end
end
