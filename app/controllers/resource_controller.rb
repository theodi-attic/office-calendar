class ResourceController < ApplicationController
  def index
    @resources = Resource.where(:active => true).group_by { |res| res.resourcetype }
  end
  
  def show
    @resource = Resource.find(params[:id])
  end
end
