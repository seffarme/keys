class LoyersController < ApplicationController
  before_action :set_bien, only: %i[create]

  def create
    @loyer = Loyer.new({
                         montant: @bien.montant_loyer,
                         date_paiement: Date.today,
                         bien_id: @bien.id,
                         locataire_id: @bien.locataires.first.id
                       })
    redirect_to bien_path(@bien) if @loyer.save
  end

  private

  def set_bien
    @bien = Bien.find(params[:bien_id])
  end
end
