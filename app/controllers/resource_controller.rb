class ResourceController < ApplicationController
  def index
    @resources = Resource.where(:active => true)
    respond_to do |format|
      format.html { @resources = @resources.group_by { |res| res.resourcetype } }
      format.json
    end
  end
  
  def show
    @resource = Resource.find(params[:id])
  end
end
