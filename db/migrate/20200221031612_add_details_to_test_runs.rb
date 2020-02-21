class AddDetailsToTestRuns < ActiveRecord::Migration[6.0]
  def change
    add_column :test_runs, :timestamp, :string
    add_column :test_runs, :status, :string
    add_reference :test_runs, :test, foreign_key: true
  end
end
