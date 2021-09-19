class RemoveCheckeFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :checke, :boolean
  end
end
