class Loyer < ApplicationRecord
  belongs_to :bien
  belongs_to :locataire

  def self.in_interval(date_debut, date_fin)
    # Get all the loyer instances from DB
    sql_query = " \
      loyers.date_paiement >= :date_debut \
      AND loyers.date_paiement <= :date_fin
      "
    loyers_in_interval = select(:montant).where(sql_query, date_debut: date_debut, date_fin: date_fin)

    # Create an array with all the loyers
    loyers = []
    loyers_in_interval.each do |depense|
      loyers << depense.montant
    end
    loyers
  end
end
