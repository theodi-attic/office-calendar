json.set!("@type", "http://schema.org/Event")
json.name "Room booking for #{event[:title]}"
json.startDate event[:start]
json.endDate event[:end]
json.pubDate event[:created]
json.location do
  json.url resource_url(resource)
end