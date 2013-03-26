json.partial! "resource/resource", resource: @resource
json.events @resource.events do |json, event|
  json.partial! "event/event", event: event, resource: @resource
end
