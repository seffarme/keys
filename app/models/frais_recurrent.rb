class FraisRecurrent < ApplicationRecord
  RECURRENCE = %w[Mensuel Annuel]

  belongs_to :bien
  has_many :depenses

  validates :nom, presence: true
  validates :montant, presence: true
  validates :date_debut, presence: true
  validates :date_fin, presence: true
  validates :recurrence, presence: true, inclusion: { in: RECURRENCE }
end
