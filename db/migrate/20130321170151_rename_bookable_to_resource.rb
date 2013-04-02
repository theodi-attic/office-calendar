class RenameBookableToResource < ActiveRecord::Migration
  def change
    rename_table :bookables, :resources
  end
end
