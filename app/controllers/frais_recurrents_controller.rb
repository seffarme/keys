class FraisRecurrentsController < ApplicationController
  def create
    @bien = Bien.find(params[:bien_id])
    @frais_recurrent = FraisRecurrent.new(frais_recurrent_params)
    @frais_recurrent.bien = @bien

    if @frais_recurrent.save
      @frais_recurrent.populate_depenses
      redirect_to bien_path(@bien)
    else
      redirect_to biens_path
    end
  end

  private

  def frais_recurrent_params
    params.require(:frais_recurrent).permit(:nom, :montant, :categorie, :recurrence, :date_debut, :date_fin)
  end
end
