class LoyersController < ApplicationController
  before_action :set_bien, only: %i[create]

  def create
    @loyer = Loyer.new({
                         montant: @bien.montant_loyer,
                         date_paiement: Date.today,
                         bien_id: @bien.id,
                         locataire_id: @bien.locataires.first.id
                       })

    previous_url = request.env["HTTP_REFERER"]
    index_url = url_for(action: 'index', controller: 'biens', only_path: false, protocol: 'http')

    if @loyer.save
      if previous_url == index_url
        redirect_to biens_path
      else
        redirect_to bien_path(@bien)
      end
    end
  end

  private

  def set_bien
    @bien = Bien.find(params[:bien_id])
  end
end
