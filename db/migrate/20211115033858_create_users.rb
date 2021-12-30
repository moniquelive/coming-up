class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :twitch_id
      t.string :twitch_name
      t.string :twitch_avatar
      t.string :twitch_access_token
      t.string :twitch_refresh_token
      t.string :session_token
      t.datetime :follows_monique_since

      t.timestamps
    end
  end
end
