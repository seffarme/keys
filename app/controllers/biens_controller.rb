class BiensController < ApplicationController
  CURRENT_YEAR = 2021
  CURRENT_START_PERIOD = Date.new(CURRENT_YEAR)
  CURRENT_END_PERIOD = Date.new(CURRENT_YEAR + 1) - 1.day

  before_action :set_biens, :any_loyer_missing_all_bien?, only: %i[index]
  before_action :set_bien, :set_report, :any_loyer_missing_this_bien?, only: %i[show update]

  def index
    @markers = @biens.geocoded.map do |bien|
      {
        lat: bien.latitude,
        lng: bien.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { bien: bien })
      }
    end
    # @sum_depenses = current_user.sum_depenses_biens

    @cfbiens = @biens.map { |bien| bien.cash_flow_bien }
    @cfbiens_months = current_user.cash_flow_biens

    @cash_flow_courbe_biens = @cfbiens_months.each_with_index.map do |n, index|
      if index.zero?
        n
      else
        @cfbiens_months[0..index].sum
      end
    end

    @months_display = (0..11).map { |i| (Date.today - i.month).end_of_month.strftime('%b %y') }.reverse
    @apartments_display = current_user.biens.map { |bien| bien.nom }
  end

  def show
    ## MERGE tableaux transactions ##
    @lasts_transactions = (@bien.loyers.where('date_paiement < ?',
    DateTime.now).order(date_paiement: :desc).limit(10).to_a + @bien.depenses.where('date_paiement < ?',
    DateTime.now).order(date_paiement: :desc).limit(10).to_a).map do |transaction|
      transaction.attributes
    end
    @lasts_transactions.sort_by! { |t| t['date_paiement'] }.reverse!
    @depenses = @bien.sum_depenses

    @cash_flow_bien_month = @bien.cash_flow_month

    @months_display = (0..11).map { |i| (Date.today - i.month).end_of_month.strftime('%b %y') }.reverse

    @cash_flow_courbe_bien = @cash_flow_bien_month.each_with_index.map do |n, index|
      if index == 0
        n
      else
        @cash_flow_bien_month[0..index].sum
      end
    end


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
        :montant_loyer,
        depenses_attributes: %i[
          id
          nom
          montant
          categorie
          date_paiement
        ]
      )
  end

  def months_display_12
    @months_display = (0..11).map { |i| (Date.today - i.month).end_of_month.strftime('%b') }
  end

  def sum_cashflow_courbe
    b = @cfbiens_months.each with_index.map do |n, index|
      if index.zero?
        n
      else tab[0..index].sum
      end
    end
  end

  def set_bien
    @bien = Bien.find(params[:id])
  end

  def set_biens
    @biens = current_user.biens
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

  def any_loyer_missing_all_bien?
    @any_loyer_missing_all_bien = @biens.any? do |bien|
      bien.loyers.empty? || bien.loyers.last.date_paiement.month != Date.today.month
    end
  end

  def any_loyer_missing_this_bien?
    @any_loyer_missing_this_bien = @bien.loyers.empty? || @bien.loyers.last.date_paiement.month != Date.today.month
  end

  # def sum_depenses
  #   @biens = current_user.biens
  #   @sum_depenses = 0
  #   @biens.each do |bien|
  #     bien.depenses.each do |depense|

  #     @sum_depenses += depense.montant
  #     end
  #   end
  #   @sum_depenses
  #     raise

  # end

  # def sum_depenses_bien
  #   @bien = Bien.find(19)
  #   @bien.depenses.each do |depense|
  #   @sum_depenses = 0
  #   @sum_depenses += depense.montant
  #     end
  #   @sum_depenses
  #     raise
  #   end

  # def sum_loyers
  #   @bien = Bien.find(params[:id])
  #   @loyers = @bien.loyers
  #   @loyers.each do |loyer|
  #     @sum_loyers = 0
  #     @sum_loyers += loyer.montant
  #   end
  # end
end
