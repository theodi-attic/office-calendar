class RenameresourceToResource < ActiveRecord::Migration
  def change
    rename_table :resources, :resources
  end
end
