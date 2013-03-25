class AddActiveToResource < ActiveRecord::Migration
  def change
    add_column :resources, :active, :boolean
  end
end
