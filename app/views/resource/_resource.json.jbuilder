json.set!("@type", "http://schema.org/Place")
json.name resource.name
json.description resource.description
json.url resource_url(resource)
json.address "65 Clifton Street, London EC2A 4JE"
json.geo do
  json.set!("@type", "http://schema.org/GeoCoordinates")
  json.latitude "51.52231"
  json.longitude "-0.08336"
end