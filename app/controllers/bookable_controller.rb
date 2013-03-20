class BookableController < ApplicationController
  def index
    @bookables = Bookable.all
  end
  
  def show
    @bookable = Bookable.find(params[:id])
  end
end
