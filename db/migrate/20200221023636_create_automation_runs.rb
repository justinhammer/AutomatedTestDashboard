class CreateAutomationRuns < ActiveRecord::Migration[6.0]
  def change
    create_table :automation_runs do |t|

      t.timestamps
    end
  end
end
