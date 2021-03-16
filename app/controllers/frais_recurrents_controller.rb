class FraisRecurrentsController < ApplicationController
  AVERAGE_DAYS_PER_MONTH = 30.44

  def create
    @bien = Bien.find(params[:bien_id])
    @frais_recurrent = FraisRecurrent.new(frais_recurrent_params)
    @frais_recurrent.bien = @bien

    if @frais_recurrent.save
      populate_depenses(@frais_recurrent)
      redirect_to bien_path(@bien)
    else
      redirect_to biens_path
    end
  end

  private

  def frais_recurrent_params
    params.require(:frais_recurrent).permit(:nom, :montant, :recurrence, :date_debut, :date_fin)
  end

  def populate_depenses(frais_recurrent)
    # Calculate the number of depenses to generate
    duration_in_days = frais_recurrent.date_fin - frais_recurrent.date_debut
    duration_in_months = (duration_in_days / AVERAGE_DAYS_PER_MONTH).to_f.ceil

    # Create the depenses
    case frais_recurrent.recurrence
    when "Mensuel"
      number_of_depenses_to_generate = duration_in_months
      (0..number_of_depenses_to_generate).each do |i|
        depense = Depense.new(nom: frais_recurrent.nom, montant: frais_recurrent.montant,
                              date_paiement: frais_recurrent.date_debut.next_month(i))
        depense.frais_recurrent = @frais_recurrent
        depense.bien = @bien
        depense.save
      end
    when "Annuel"
      number_of_depenses_to_generate = (duration_in_months / 12).to_f.floor
      (0..number_of_depenses_to_generate).each do |i|
        depense = Depense.new(nom: frais_recurrent.nom, montant: frais_recurrent.montant,
                              date_paiement: frais_recurrent.date_debut.next_year(i))
        depense.frais_recurrent = @frais_recurrent
        depense.bien = @bien
        depense.save
      end
    end
  end
end
