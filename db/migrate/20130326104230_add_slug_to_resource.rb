class AddSlugToResource < ActiveRecord::Migration
  def change
    add_column :resources, :slug, :string
    add_index :resources, :slug, unique: true
  end
end
