class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :title
      t.text :description
      t.text :motive_image

      t.timestamps null: false
    end
  end
end
