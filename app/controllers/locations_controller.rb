class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])

    if @location.valid?
      redirect_to location_path(@location.name)
    else
      flash.now.alert = t('alerts.enter_location') 
      render :new
    end
  end

  def show
    @location = Location.new(name: params[:id])

    unless @location.weather.success?
      flash.now.alert = t('alerts.location_invalid') 
      render :new
    end
  end
end
