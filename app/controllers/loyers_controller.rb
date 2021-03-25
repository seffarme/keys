class LoyersController < ApplicationController
  before_action :set_bien, only: %i[create relance]

  def create
    @loyer = Loyer.new({
                         montant: @bien.montant_loyer,
                         date_paiement: Date.today,
                         bien_id: @bien.id,
                         locataire_id: @bien.locataires.first.id
                       })
    @loyer.save

    LoyerMailer.create_quittance(@loyer).deliver_now
    LoyerMailer.copie_create_quittance(@loyer).deliver_now

    redirect_to params[:target], success: "💸 Loyer de #{@loyer.bien.nom} validé !"
  end

  def relance
    LoyerMailer.relance(@bien).deliver_now
    LoyerMailer.copie_relance(@bien).deliver_now
    redirect_to biens_path(anchor: 'biens-list'), relance_loyer: "📧 Relance envoyée au locataire de #{@bien.nom}"
  end

  private

  def set_bien
    @bien = Bien.find(params[:bien_id])
  end
end
