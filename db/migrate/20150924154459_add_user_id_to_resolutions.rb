class AddUserIdToResolutions < ActiveRecord::Migration
  def change
    add_reference :resolutions, :user, index: true, foreign_key: true
  end
end
