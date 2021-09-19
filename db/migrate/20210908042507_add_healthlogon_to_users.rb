class AddHealthlogonToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :health_log_on, :date
  end
end
