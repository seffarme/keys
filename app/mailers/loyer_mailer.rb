class LoyerMailer < ApplicationMailer

  def create_quittance(loyer)
    @loyer = loyer
    @locataire = @loyer.locataire
    @bien = @loyer.bien
    mail(to: @locataire.email, subject:  "votre quittance pour la #{@bien.categorie} de #{@bien.nom}")
  end

  def relance(bien)
    @bien = bien
    @locataire = @bien.locataires.first
    mail(to: @locataire.email, subject:  "RELANCE - Avis d'échéance pour la #{@bien.categorie} de #{@bien.nom}")
  end
end