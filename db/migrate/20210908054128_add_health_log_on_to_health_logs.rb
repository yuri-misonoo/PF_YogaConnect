class AddHealthLogOnToHealthLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :health_logs, :health_log_on, :date
  end
end
