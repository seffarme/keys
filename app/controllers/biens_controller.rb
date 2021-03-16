class BiensController < ApplicationController
  def index
    @biens = current_user.biens
    @markers = @biens.geocoded.map do |bien|
      {
        lat: bien.latitude,
        lng: bien.longitude
      }
    end
  end

  def show
    @bien = Bien.find(params[:id])
    @markers = @biens.geocoded.map do |bien|
      {
        lat: bien.latitude,
        lng: bien.longitude
      }
    end
  end
end
