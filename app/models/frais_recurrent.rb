class FraisRecurrent < ApplicationRecord
  RECURRENCE = %w[Mensuel Annuel]

  belongs_to :bien
  has_many :depenses

  validates :recurrence, inclusion: { in: RECURRENCE }
end
