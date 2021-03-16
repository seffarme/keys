class BiensController < ApplicationController
  def index

  end

  def show
    @bien = Bien.find(params[:id])
  end
end
