class LoyerMailer < ApplicationMailer

  def create_quittance(loyer)
    @loyer = loyer
    @locataire = @loyer.locataire
    @bien = @loyer.bien
    mail(to: @locataire.email, subject:  "Votre quittance : #{@bien.nom}")
  end


  def copie_create_quittance(loyer)
    @loyer = loyer
    @locataire = @loyer.locataire
    @bien = @loyer.bien
    mail(to: @bien.user.email, subject:  "// COPIE // - Votre quittance : #{@bien.nom}")
  end

  def relance(bien)
    @bien = bien
    @locataire = @bien.locataires.first
    mail(to: @locataire.email, subject:  "RELANCE - Avis d'échéance : #{@bien.nom}")
  end

  def copie_relance(bien)
    @bien = bien
    @locataire = @bien.locataires.first
    mail(to: @bien.user.email, subject:  "// COPIE // RELANCE - Avis d'échéance : #{@bien.nom}")
  end
end