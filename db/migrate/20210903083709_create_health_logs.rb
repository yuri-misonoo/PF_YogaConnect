class CreateHealthLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :health_logs do |t|
      t.integer :user_id
      t.string :weight
      t.string :temperature
      t.integer :feeling, default: 2
      t.text :memo
      t.text :exercise
      t.text :morning
      t.text :lunch
      t.text :dinner
      t.string :date

      t.timestamps
    end
  end
end
