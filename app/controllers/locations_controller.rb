class LocationsController < ApplicationController

  respond_to :html

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    flash.now.alert = t('alerts.enter_location') unless @location.valid?
    respond_with(@location)
  end
end
