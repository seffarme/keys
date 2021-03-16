class BiensController < ApplicationController
  
  def index

  end
  
	def new
		@bien = Bien.new
	end
  
  def show
    @bien = Bien.find(params[:id])
  end
  
	def create
	  # @bien = Bien.find(params[:bien_id])
		# @bien = Bien.new(params[:bien])
    # @bien.save
	# end

    @bien = Bien.new(bien_params)
    @bien.save
		@bien.user = current_user

    # no need for app/views/biens/create.html.erb
    redirect_to bien_path(@bien)
  end

  private

  def bien_params
    params.require(:bien).permit(:nom, :categorie, :adresse, :ville, :code_postal, :pays, :info_compl_adresse, :surface, :nb_pieces, :nb_sdb, :nb_etages, :num_etage, :annee_construction, :prix_acquisition, :date_acquisition, :frais_achat_notaire, :frais_achat_agence, :frais_achat_travaux, :frais_achat_autres)

end
