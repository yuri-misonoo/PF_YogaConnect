class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :post_id
      t.integer :post_comment_id
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.string :action, null: false, default: ''
      t.boolean :checke, null: false, default: false

      t.timestamps
    end
    
    add_index :notifications, :post_id
    add_index :notifications, :post_comment_id
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    
  end
end
