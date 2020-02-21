class AddDetailsToTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :owner, :string
    add_column :tests, :name, :string
  end
end
