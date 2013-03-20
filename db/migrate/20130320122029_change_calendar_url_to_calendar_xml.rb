class ChangeCalendarUrlToCalendarXml < ActiveRecord::Migration
  def change
    rename_column :bookables, :calendar_url, :calendar_xml
  end
end
