class Depense < ApplicationRecord
  CATEGORIE = %w[Crédit Taxe\ Foncière Copropriété Assurances Travaux Autres]

  belongs_to :bien
  belongs_to :frais_recurrent, optional: true

  validates :nom, presence: true
  validates :montant, presence: true
  validates :categorie, presence: true, inclusion: { in: CATEGORIE }
  validates :date_paiement, presence: true

  scope :cat_credit, -> { where("categorie = 'Crédit'") }
  scope :cat_taxe_fonciere, -> { where("categorie = 'Taxe Foncière'") }
  scope :cat_copropriete, -> { where("categorie = 'Copropriété'") }
  scope :cat_assurances, -> { where("categorie = 'Assurances'") }
  scope :cat_travaux, -> { where("categorie = 'Travaux'") }
  scope :cat_autres, -> { where("categorie = 'Autres'") }

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
