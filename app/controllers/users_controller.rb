class UsersController < ApplicationController

  def index

  end

  def show
    @user = User.find(params[:id])
    @biens = Bien.all
    @markers = @biens.geocoded.map do |bien|
      {
        lat: bien.latitude,
        lng: bien.longitude
      }
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:prenom, :nom, :email, :num_tel)
  end
end
