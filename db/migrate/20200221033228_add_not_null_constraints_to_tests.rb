class AddNotNullConstraintsToTests < ActiveRecord::Migration[6.0]
  def change
    change_column :tests, :name, :string, null: false
    change_column :tests, :owner, :string, null: false
  end
end
