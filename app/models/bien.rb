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
    depenses.each do |depense|
      sum_depenses += depense.montant
    end
    sum_depenses
  end

  def sum_loyers
    sum_loyers = 0
    loyers.each do |loyer|
      sum_loyers += loyer.montant
    end
    sum_loyers
  end

  def cash_flow_bien
    sum_loyers - sum_depenses
  end

  def sum_depenses_to_date
    a = Time.now.beginning_of_month + 1.month
    depenses.where("date_paiement < ?", a).sum(:montant)
  end

  def total_cash_flow
    biens.each { |bien| bien.cash_flow_bien_to_date }.sum
  end

  def total
    cash_flow_bien_to_date
  end

  def months_depenses_to_date
    months_depenses = (0..11).to_a.map do |i|
      a = Time.now.beginning_of_month - 1000.month
      b = Time.now.end_of_month - i.month
      depenses.where("date_paiement > ? AND date_paiement < ?", a, b).sum(:montant)
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

  # Depenses table of the last 12 months
  def months_depenses
    months_depenses = (0..11).to_a.map do |i|
      a = Time.now.beginning_of_month - i.month
      b = Time.now.end_of_month - i.month
      depenses.where("date_paiement > ? AND date_paiement < ?", a, b).sum(:montant)
    end
    return months_depenses
  end

  # Loyers table of the last 12 months
  def months_loyers
    months_loyers = (0..11).to_a.map do |i|
      a = Time.now.beginning_of_month - i.month
      b = Time.now.end_of_month - i.month
      loyers.where("date_paiement > ? AND date_paiement < ?", a, b).sum(:montant)
    end
    return months_loyers
  end

  # CF table of the last 12 months
  def cash_flow_month
    months_loyers.each_with_index.map do |loyer, index|
      loyer - months_depenses[index]
    end
  end

  # KPI's
  # Result since beginning
  def cash_flow_bien_to_date
    sum_loyers - sum_depenses_to_date
  end

  # Rentability YTD
  def net_ytd_rentability
    sum_loyers_depenses_ytd = cash_flow_month.reduce(0) { |sum, cash_flow_per_month| sum + cash_flow_per_month }
    (sum_loyers_depenses_ytd / prix_acquisition.to_f) * 100
  end
end
