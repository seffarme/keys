class Depense < ApplicationRecord
  belongs_to :bien
  belongs_to :frais_recurrent, optional: true

  def self.in_interval(date_debut, date_fin)
    # Get all the depense instances from DB
    sql_query = " \
      depenses.date_paiement >= :date_debut \
      AND depenses.date_paiement <= :date_fin
      "
    depenses_in_interval = select(:montant).where(sql_query, date_debut: date_debut, date_fin: date_fin)

    # Create an array with all the depenses
    depenses = []
    depenses_in_interval.each do |depense|
      depenses << depense.montant
    end
    depenses
  end
end
