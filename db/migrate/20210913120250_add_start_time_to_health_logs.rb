class AddStartTimeToHealthLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :health_logs, :start_time, :datetime
  end
end
