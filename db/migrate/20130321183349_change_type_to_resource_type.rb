class ChangeTypeToResourceType < ActiveRecord::Migration
  def change
    rename_column :resources, :type, :resourcetype
  end
end
