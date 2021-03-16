class Proprietaire < ApplicationRecord
  TYPE_BIEN = %w[Appartement Maison]

  has_many :biens

  validates :type, inclusion: { in: TYPE_BIEN }
end
