class Bien < ApplicationRecord
  geocoded_by :adresse
  after_validation :geocode, if: :will_save_change_to_adresse?
  belongs_to :user

  has_many :loyers
  accepts_nested_attributes_for :loyers

  has_many :depenses
  accepts_nested_attributes_for :depenses

  has_many :frais_recurrents
  has_many :locataires

  CATEGORIE_BIEN = %w[Appartement Maison]
  validates :montant_loyer, presence: true
  validates :categorie, inclusion: { in: CATEGORIE_BIEN }
# second graph

  def sum_depenses
      sum_depenses = 0
    self.depenses.each do |depense|
      sum_depenses += depense.montant
    end
    sum_depenses
  end

  def sum_loyers
    sum_loyers = 0
    self.loyers.each do |loyer|
      sum_loyers += loyer.montant
    end
    sum_loyers
  end

  def cash_flow_bien
   self.sum_loyers - self.sum_depenses
  end

  def months_depenses_to_date
    months_depenses = (0..11).to_a.map do |i|
     a = Time.now.beginning_of_month - (1000).month
     b = Time.now.end_of_month - i.month
     self.depenses.where("date_paiement > ? AND date_paiement < ?", a , b).sum(:montant)
    end
    return months_depenses
  end
# first graph


  # @months = []
  # (1..12).each {|m| @months << Date::MONTHNAMES}
  # @months

  # date = Date.today.beginning_of_year
  # months = {}


  # 12.times do |i| # from 0 to 11

  #   month_name = I18n.l(Date.today.beginning_of_year + 1.months, format: '%B', locale: :en).capitalize
  #   months[month_name] = i + 1



  def months_depenses
    months_depenses = (0..11).to_a.map do |i|
     a = Time.now.beginning_of_month - i.month
     b = Time.now.end_of_month - i.month
     self.depenses.where("date_paiement > ? AND date_paiement < ?", a , b).sum(:montant)
    end
    return months_depenses
  end

  def months_loyers
    months_loyers = (0..11).to_a.map do |i|
     a = Time.now.beginning_of_month - i.month
     b = Time.now.end_of_month - i.month
     self.loyers.where("date_paiement > ? AND date_paiement < ?", a , b).sum(:montant)
    end
    return months_loyers
  end

  def cash_flow_month
    months_loyers.each_with_index.map do |loyer, index|
      loyer - months_depenses[index]
    end
  end
end

