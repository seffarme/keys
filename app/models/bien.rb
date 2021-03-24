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

  # def total_cash_flow
  #   biens.each { |bien| bien.cash_flow_bien_to_date }.sum
  # end

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

  # Depenses table of the last 12 months

  def months_depenses
    @months_depenses ||= calc_months_depenses
  end

  def calc_months_depenses
    sql_months = (0...12).map {|i| "SELECT #{(Date.today - i.months).month} as mm, #{i} as pos"}.join(' UNION ALL ')
    sql = <<~SQL
      SELECT COALESCE(sum(montant), 0)
      FROM (#{sql_months}) months
      LEFT JOIN depenses on EXTRACT('MONTH' FROM depenses.date_paiement)
       = months.mm AND depenses.date_paiement < date_trunc('month', now()) + interval '1 month'
            AND depenses.date_paiement >= date_trunc('month', now()) - interval '11 month'
            AND depenses.bien_id = #{id}
            GROUP BY months.mm, months.pos
       ORDER by months.pos
    SQL
    ActiveRecord::Base.connection.exec_query(sql).rows.flatten
  end

  # Loyers table of the last 12 months

  def months_loyers
    @months_loyers ||= calc_months_loyers
  end

  def calc_months_loyers
    sql_months = (0...12).map {|i| "SELECT #{(Date.today - i.months).month} as mm, #{i} as pos"}.join(' UNION ALL ')
    sql = <<~SQL
      SELECT COALESCE(sum(montant), 0)
      FROM (#{sql_months}) months
      LEFT JOIN loyers on EXTRACT('MONTH' FROM loyers.date_paiement)
       = months.mm AND loyers.date_paiement < date_trunc('month', now()) + interval '1 month'
            AND loyers.date_paiement >= date_trunc('month', now()) - interval '11 month'
            AND loyers.bien_id = #{id}

            GROUP BY months.mm, months.pos
       ORDER by months.pos
    SQL
    ActiveRecord::Base.connection.exec_query(sql).rows.flatten
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
