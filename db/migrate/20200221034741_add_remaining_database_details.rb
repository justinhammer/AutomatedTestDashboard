class AddRemainingDatabaseDetails < ActiveRecord::Migration[6.0]
  def change
    change_column :test_runs, :timestamp, :string, null: false
    change_column :test_runs, :status, :string, null: false

    add_column :automation_runs, :timestamp, :string, null: false, unique: true
    add_column :automation_runs, :os, :string, null: false
    add_column :automation_runs, :build_number, :integer, null: false
  end
end
