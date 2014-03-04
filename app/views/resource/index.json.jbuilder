json.resources @resources do |resource|
  json.partial! "resource/resource", resource: resource
  json.events resource.events do |event|
    json.partial! "event/event", event: event, resource: resource
  end
end