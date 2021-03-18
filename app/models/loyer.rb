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

puts "git"
# @biens = Bien.all // [Bien1, Bien2, ...., BienN]
# @biens.reduce(0) { |sum, loyer_bien| bien.loyers.in_interval().reduce}

# Loyer.sum(:loyer)

# loyer_per_months = {
#   0 => 453433,
#   1 => 453433,
#   0 => 453433,
#   0 => 453433,
# }

# loyer_per_months = {}

# (1..Date.current.month).each do |month|
#   date_debut = Date.current.change(month: month).beginning_of_month
#   date_fin = Date.current.change(month: month).end_of_month

#   loyer_per_months[month] = current_user.loyers.where().sum(:montant)
# end
