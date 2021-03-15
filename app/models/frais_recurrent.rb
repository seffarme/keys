class FraisRecurrent < ApplicationRecord
  belongs_to :bien
  has_many :depenses
end
