class Depense < ApplicationRecord
  belongs_to :bien
  belongs_to :frais_recurrent, optional: true

  def self.in_interval(date_debut, date_fin)
    sql_query = " \
      depenses.date_paiement >= :date_debut \
      AND depenses.date_paiement <= :date_fin
      "
    @depenses = self.select(:montant).where(sql_query, date_debut: date_debut, date_fin: date_fin)
  end

end
