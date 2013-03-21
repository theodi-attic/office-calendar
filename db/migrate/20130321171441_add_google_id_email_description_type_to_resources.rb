class AddGoogleIdEmailDescriptionTypeToResources < ActiveRecord::Migration
  def change
    add_column :resources, :google_id, :text
    add_column :resources, :email, :text
    add_column :resources, :description, :text
    add_column :resources, :type, :text
  end
end
