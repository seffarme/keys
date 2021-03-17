class DepensesController < ApplicationController
  def create
    @bien = Bien.find(params[:bien_id])
    @depense = Depense.new(depense_params)
    @depense.bien = @bien

    if @depense.save
      redirect_to bien_path(@bien)
    else
      redirect_to biens_path
    end
  end

  private

  def depense_params
    params.require(:depense).permit(:nom, :montant, :date_paiement)
  end
end
