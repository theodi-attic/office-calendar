class ResourceController < ApplicationController
  def index
    @resources = Resource.where(:active => true)
    respond_to do |format|
      format.html { @resources = @resources.group_by { |res| res.resourcetype } }
      format.json
      format.ics { @calendar = Icalendar::Calendar.new }
    end
  end
  
  def show
    @resource = Resource.find(params[:id])
    respond_to do |format|
      format.html
      format.json
      format.ics { @calendar = Icalendar::Calendar.new }
    end
  end
end
