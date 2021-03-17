class FraisRecurrent < ApplicationRecord
  RECURRENCE = %w[Mensuel Annuel]
  CATEGORIE = %w[Crédit Taxe\ Foncière Copropriété Assurances]

  belongs_to :bien
  has_many :depenses

  validates :nom, presence: true
  validates :montant, presence: true
  validates :categorie, presence: true, inclusion: { in: CATEGORIE }
  validates :date_debut, presence: true
  validates :date_fin, presence: true
  validates :recurrence, presence: true, inclusion: { in: RECURRENCE }
end
