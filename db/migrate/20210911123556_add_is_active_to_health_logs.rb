class AddIsActiveToHealthLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :health_logs, :is_active, :boolean, default: true
  end
end
