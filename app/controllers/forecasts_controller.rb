class ForecastsController < ApplicationController
  def show
    @address_default = "311 W Heather Way, La Habra, CA 90631"
    session[:address] = params[:address]
    if params[:address]
      begin
        @address = params[:address]
        geosearch = Geocoder.search(@address).first
        coordinates = geosearch.coordinates
        @weather_cache_key = "#{geosearch.data['address']['country_code']}/#{geosearch.data['osm_id']}"
        @weather_cache_exist = Rails.cache.exist?(@weather_cache_key)
        @weather = Rails.cache.fetch(@weather_cache_key, expires_in: 30.minutes) do
          WeatherService.call(coordinates.first, coordinates.last)
        end
      rescue => e
        flash.alert = e.message
      end
    end
  end
end