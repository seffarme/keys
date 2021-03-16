class FraisRecurrentsController < ApplicationController
  def create
    @bien = Bien.find(params[:id])
    @frais_recurrent = FraisRecurrent.new(frais_recurrents_params)
    populate_depenses(@frais_recurrent)

    redirect_to bien_path(@bien)
  end

  private

  def frais_recurrent_params
    params.require(:frais_recurrent).permit(:nom, :montant, :recurrence, :date_debut, :date_fin)
  end

  def populate_depenses(frais_recurrent)
    # Calculate the number of depenses to generate
    frais_duree_en_mois = frais_recurrent.date_fin - frais_recurrent.date_debut

    number_of_depenses_to_generate = case frais_duree_en_mois
                                     when "Mensuel" then frais_duree_en_mois
                                     when "Annuel" then (frais_duree_en_mois / 12).floor
                                     end

    # Create the depenses
    puts "eee"
  end
end
