class Bien < ApplicationRecord
  geocoded_by :adresse
  after_validation :geocode, if: :will_save_change_to_adresse?
  belongs_to :user

  has_many :loyers
  accepts_nested_attributes_for :loyers

  has_many :depenses
  accepts_nested_attributes_for :depenses

  has_many :frais_recurrents
  has_many :locataires

  CATEGORIE_BIEN = %w[Appartement Maison]
  validates :montant_loyer, presence: true
  validates :categorie, inclusion: { in: CATEGORIE_BIEN }
end
