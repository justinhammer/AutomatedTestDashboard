class AddUniqueConstraintToTests < ActiveRecord::Migration[6.0]
  def change
    add_index :tests, :name, unique: true
  end
end
