class AddResolutionIdToReminders < ActiveRecord::Migration
  def change
    add_reference :reminders, :resolution, index: true, foreign_key: true
  end
end
