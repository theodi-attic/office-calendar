class RemoveIcalAndXml < ActiveRecord::Migration
  def change
    remove_column :resources, :calendar_xml
    remove_column :resources, :calendar_ical
  end
end
