class CreateTestRuns < ActiveRecord::Migration[6.0]
  def change
    create_table :test_runs do |t|

      t.timestamps
    end
  end
end
