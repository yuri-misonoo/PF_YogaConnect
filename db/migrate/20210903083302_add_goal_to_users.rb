class AddGoalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_image_id, :string
    add_column :users, :goal_weight, :string
    add_column :users, :goal, :text
  end
end
