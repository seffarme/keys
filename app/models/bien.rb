class Bien < ApplicationRecord
  geocoded_by :adresse
  after_validation :geocode, if: :will_save_change_to_adresse?
  belongs_to :user
  has_many :depenses
  has_many :frais_recurrents
  has_many :loyers
  has_many :locataires

  CATEGORIE_BIEN = %w[Appartement Maison]
  validates :categorie, inclusion: { in: CATEGORIE_BIEN }

  scope :depenses_in_interval, lambda { |date_debut, date_fin|
                                 joins("JOIN depenses ON depenses.bien_id = biens.id").where("depenses.date_paiement >= ? AND depenses.date_paiement <= ?", date_debut, date_fin)
                               }
  scope :loyers_in_interval, lambda { |date_debut, date_fin|
                               joins("JOIN loyers ON loyers.bien_id = biens.id").where("loyers.date_paiement >= ? AND loyers.date_paiement <= ?", date_debut, date_fin)
                             }
end
