class Locataire < ApplicationRecord
  belongs_to :bien
  has_many :loyers
end
