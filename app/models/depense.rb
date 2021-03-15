class Depense < ApplicationRecord
  belongs_to :bien
  belongs_to :frais_recurrent, optional: true
end
