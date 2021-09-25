class AddRoomIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :room_id, :integer
    add_index :notifications, :room_id
  end
end
