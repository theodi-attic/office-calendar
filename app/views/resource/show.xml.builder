xml.instruct!
xml.rdf :RDF, "xmlns:rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#", "xmlns" => "http://purl.org/rss/1.0/", "xmlns:ev" => "http://schema.org/Event#", "xmlns:place" => "http://schema.org/Place#" do
  xml.channel do
    xml.title @resource.name, "type" => "text"
    xml.description "Bookings for the #{@resource.name} at the ODI offices", "type" => "text"
  end
  xml.items do
    xml.rdf :Seq do
      @resource.events.each do |event|
        xml.rdf :li, "rdf:resource" => "#{resource_url(@resource)}##{event[:id]}"
      end
    end
  end
  @resource.events.each do |event|
    xml.item "rdf:about" => "#{resource_url(@resource)}##{event[:id]}" do
      xml.title "Room booking for #{event[:title]}"
      xml.ev :startDate, event[:start].strftime("%F %H:%M:%S")
      xml.ev :endDate, event[:end].strftime("%F %H:%M:%S")
      xml.ev :location do
        xml.place :name => @resource.name
        xml.place :address => "65 Clifton Street, London EC2A 4JE"
        xml.place :url => resource_url(@resource)
      end
      xml.pubDate event[:created]
    end
  end
end

# xml.feed "xmlns" => "http://www.w3.org/2005/Atom", "xmlns:ev" => "http://purl.org/rss/1.0/modules/event/" do
#   xml.id "ID goes here"
#   xml.updated @resource.updated_at
#   xml.title @resource.name, "type" => "text"
#   xml.subtitle @resource.description, "type" => "text"
#   @resource.events.each do |event|
#     xml.entry do
#       xml.title "Room booking"
#       xml.content event[:title]
#       xml.ev :startdate, event[:start].strftime("%F %H:%M:%S")
#       xml.ev :enddate, event[:end].strftime("%F %H:%M:%S")
#     end
#   end
# end