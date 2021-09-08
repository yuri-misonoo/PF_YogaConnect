class RemoveDateFromHealthLogOns < ActiveRecord::Migration[5.2]
  def change
    remove_column :health_logs, :date, :string
  end
end
