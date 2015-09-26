class AddDefaultToResolutionsFinished < ActiveRecord::Migration
  def change
    change_column :resolutions, :finished, :boolean, default: false
  end
end
