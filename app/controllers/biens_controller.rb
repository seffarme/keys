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

	def new
		@bien = Bien.new
	end

	def create
		@bien = Bien.new(bien_params)
		@user = current_user
		@bien.user = @user
		if @bien.save
			redirect_to bien_path(@bien)
		else
			render :new
		end
	end

	private
	def bien_params
		params.require(:bien).permit(:nom, :categorie, :adresse, :ville, :code_postal, :pays, :info_compl_adresse, :surface, :nb_pieces, :nb_sdb, :nb_etages,:num_etage,:annee_construction, :prix_acquisition, :date_acquisition, :frais_achat_notaire, :frais_achat_agence, :frais_achat_travaux, :frais_achat_autres)
	end
end
