class BiensController < ApplicationController
  CURRENT_YEAR = 2021
  CURRENT_START_PERIOD = Date.new(CURRENT_YEAR)
  CURRENT_END_PERIOD = Date.new(CURRENT_YEAR + 1) - 1.day

  before_action :set_bien, :set_report, only: %i[show update]

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
  end

  def update
    @bien.attributes = bien_params

    if @bien.save
      redirect_to bien_path(@bien)
    else
      render :show
    end
  end

  def new
    @bien = Bien.new
  end

  def create
    @bien = Bien.new(bien_params)
    @bien.user = current_user

    if @bien.save
      redirect_to bien_path(@bien)
    else
      render :new
    end
  end

  private

  def bien_params
    params
      .require(:bien)
      .permit(
        :nom,
        :categorie,
        :adresse,
        :ville,
        :code_postal,
        :pays,
        :info_compl_adresse,
        :surface,
        :nb_pieces,
        :nb_sdb,
        :nb_etages,
        :num_etage,
        :annee_construction,
        :prix_acquisition,
        :date_acquisition,
        :frais_achat_notaire,
        :frais_achat_agence,
        :frais_achat_travaux,
        :frais_achat_autres,
        depenses_attributes: %i[
          id
          nom
          montant
          categorie
          date_paiement
        ]
      )
  end

  def set_bien
    @bien = Bien.find(params[:id])
  end

  def set_report
    ############################ Generate the loyers paid & to be paid ###########################################
    @loyers_received_list = @bien.loyers.in_interval(CURRENT_START_PERIOD, Date.today)
    @loyers_received = @loyers_received_list.reduce(0) { |sum, loyer| sum + loyer }

    # Simulate future loyers
    @test = (12 - @loyers_received_list.count)

    ############################ Generate the depenses paid & to be paid ###########################################
    # CREDIT
    @credits_paid_list = @bien.depenses.cat_credit.in_interval(CURRENT_START_PERIOD, Date.today)
    @credits_paid = @credits_paid_list.reduce(0) { |sum, credit| sum + credit }

    @credits_tbp_list = @bien.depenses.cat_credit.in_interval(Date.today, CURRENT_END_PERIOD)
    @credits_tbp = @credits_tbp_list.reduce(0) { |sum, credit| sum + credit }

    # TAXE FONCIERE
    @taxe_fonciere_paid_list = @bien.depenses.cat_taxe_fonciere.in_interval(CURRENT_START_PERIOD, Date.today)
    @taxe_fonciere_paid = @taxe_fonciere_paid_list.reduce(0) { |sum, taxe_fonciere| sum + taxe_fonciere }

    @taxe_fonciere_tbp_list = @bien.depenses.cat_taxe_fonciere.in_interval(Date.today, CURRENT_END_PERIOD)
    @taxe_fonciere_tbp = @taxe_fonciere_tbp_list.reduce(0) { |sum, taxe_fonciere| sum + taxe_fonciere }

    # COPROPRIETE
    @copropriete_paid_list = @bien.depenses.cat_copropriete.in_interval(CURRENT_START_PERIOD, Date.today)
    @copropriete_paid = @copropriete_paid_list.reduce(0) { |sum, copropriete| sum + copropriete }

    @copropriete_tbp_list = @bien.depenses.cat_copropriete.in_interval(Date.today, CURRENT_END_PERIOD)
    @copropriete_tbp = @copropriete_tbp_list.reduce(0) { |sum, copropriete| sum + copropriete }

    # ASSURANCES
    @assurances_paid_list = @bien.depenses.cat_assurances.in_interval(CURRENT_START_PERIOD, Date.today)
    @assurances_paid = @assurances_paid_list.reduce(0) { |sum, assurance| sum + assurance }

    @assurances_tbp_list = @bien.depenses.cat_assurances.in_interval(Date.today, CURRENT_END_PERIOD)
    @assurances_tbp = @assurances_tbp_list.reduce(0) { |sum, assurance| sum + assurance }

    # TRAVAUX
    @travaux_paid_list = @bien.depenses.cat_travaux.in_interval(CURRENT_START_PERIOD, Date.today)
    @travaux_paid = @travaux_paid_list.reduce(0) { |sum, travaux| sum + travaux }

    @travaux_tbp_list = @bien.depenses.cat_travaux.in_interval(Date.today, CURRENT_END_PERIOD)
    @travaux_tbp = @travaux_tbp_list.reduce(0) { |sum, travaux| sum + travaux }

    # AUTRES
    @autres_paid_list = @bien.depenses.cat_autres.in_interval(CURRENT_START_PERIOD, Date.today)
    @autres_paid = @autres_paid_list.reduce(0) { |sum, autres| sum + autres }

    @autres_tbp_list = @bien.depenses.cat_autres.in_interval(Date.today, CURRENT_END_PERIOD)
    @autres_tbp = @autres_tbp_list.reduce(0) { |sum, autres| sum + autres }
  end
end
