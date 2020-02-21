class AddForeignKeyToTestRuns < ActiveRecord::Migration[6.0]
  def change
    add_reference :test_runs, :automation_runs, foreign_key: true
  end
end
