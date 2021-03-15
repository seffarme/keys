class Loyer < ApplicationRecord
  belongs_to :bien
  belongs_to :locataire
end
