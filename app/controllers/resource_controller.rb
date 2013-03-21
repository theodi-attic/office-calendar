class ResourceController < ApplicationController
  def index
    @resources = Resource.all.group_by { |res| res.resourcetype }
  end
  
  def show
    @resource = Resource.find(params[:id])
  end
end
