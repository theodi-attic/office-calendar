class AddICaltoBookables < ActiveRecord::Migration
  def change
    add_column :bookables, :calendar_ical, :text
  end
end
