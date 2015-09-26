class AddFinishedToResolutions < ActiveRecord::Migration
  def change
    add_column :resolutions, :finished, :boolean
  end
end
