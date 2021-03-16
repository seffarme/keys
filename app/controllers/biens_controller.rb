class BiensController < ApplicationController
  def index
    @biens = current_user.biens
  end

  def show
    @bien = Bien.find(params[:id])
  end
end
