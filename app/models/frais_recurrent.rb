class FraisRecurrent < ApplicationRecord
  RECURRENCE = %w[Mensuel Annuel]
  CATEGORIE = %w[Crédit Taxe\ Foncière Copropriété Assurances Travaux Autres]
  AVERAGE_DAYS_PER_MONTH = 30.44

  belongs_to :bien
  has_many :depenses

  validates :nom, presence: true
  validates :montant, presence: true
  validates :categorie, presence: true, inclusion: { in: CATEGORIE }
  validates :date_debut, presence: true
  validates :date_fin, presence: true
  validates :recurrence, presence: true, inclusion: { in: RECURRENCE }

  def populate_depenses(bien)
    # Calculate the number of depenses to generate
    duration_in_days = date_fin - date_debut
    duration_in_months = (duration_in_days / AVERAGE_DAYS_PER_MONTH).to_f.ceil

    puts "test for commit"
    # Create the depenses
    case recurrence
    when "Mensuel"
      number_of_depenses_to_generate = duration_in_months
      (0..number_of_depenses_to_generate).each do |i|
        depense = Depense.new(nom: nom, montant: montant,
                              categorie: categorie, date_paiement: date_debut.next_month(i))
        depense.frais_recurrent = self
        depense.bien = bien
        depense.save
      end
    when "Annuel"
      number_of_depenses_to_generate = (duration_in_months / 12).to_f.floor
      (0..number_of_depenses_to_generate).each do |i|
        depense = Depense.new(nom: nom, montant: montant,
                              categorie: categorie, date_paiement: date_debut.next_year(i))
        depense.frais_recurrent = self
        depense.bien = bien
        depense.save
      end
    end
  end
end
