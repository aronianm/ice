class RequestChatTable < ActiveRecord::Migration[7.0]
  def change
    create_table :request_chats do |t|
      t.integer :user_id
      t.integer :trainor_id
      t.boolean :accepted
      t.timestamps
    end
  end
end
