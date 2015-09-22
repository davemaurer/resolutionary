class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :profile_image
      t.string :oath_token
      t.string :oauth_token_secret

      t.timestamps null: false
    end
  end
end
