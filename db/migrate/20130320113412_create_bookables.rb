class CreateBookables < ActiveRecord::Migration
  def change
    create_table :bookables do |t|
      t.text :name
      t.text :calendar_url

      t.timestamps
    end
  end
end
