class BiensController < ApplicationController
  CURRENT_YEAR = 2021

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
    # @markers = @biens.geocoded.map do |bien|
    #   {
    #     lat: bien.latitude,
    #     lng: bien.longitude
    #   }
    # end
    @depenses = Depense.all
    @frais_recurrent = FraisRecurrent.new
    @depense = Depense.new

    @loyers_collectes_liste = @bien.loyers.in_interval(Date.new(CURRENT_YEAR), Date.today)
    @loyers_collectes = @loyers_collectes_liste.reduce(0) { |sum, loyer| sum + loyer }

    @depenses_collectees_liste = @bien.depenses.in_interval(Date.new(CURRENT_YEAR), Date.today)
    @depenses_collectees = @depenses_collectees_liste.reduce(0) { |sum, depense| sum + depense }
    raise
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
    params.require(:bien).permit(:nom, :categorie, :adresse, :ville, :code_postal, :pays, :info_compl_adresse, :surface,
                                 :nb_pieces, :nb_sdb, :nb_etages, :num_etage, :annee_construction, :prix_acquisition, :date_acquisition, :frais_achat_notaire, :frais_achat_agence, :frais_achat_travaux, :frais_achat_autres)
  end
end
