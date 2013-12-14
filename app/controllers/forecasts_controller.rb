class ForecastsController < ApplicationController

  respond_to :html

  def new
    @forecast = Forecast.new
  end

  def create
    @forecast = Forecast.new(params[:forecast])
    flash.now.alert = t('alerts.enter_location') unless @forecast.valid?
    respond_with(@forecast)
  end
end
