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
    @weather = WorldWeather::Weather.new.get(params[:id])
    unless @weather.valid?
      redirect_to new_location_path, alert: t('alerts.location_invalid')
    end
  end
end
