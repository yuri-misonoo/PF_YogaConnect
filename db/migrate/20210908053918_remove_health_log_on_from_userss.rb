class RemoveHealthLogOnFromUserss < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :health_log_on, :date
  end
end
