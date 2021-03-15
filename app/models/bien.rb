class Bien < ApplicationRecord
  belongs_to :user
  has_many :depenses
  has_many :frais_recurrents
  has_many :loyers
  has_many :locataires
end
