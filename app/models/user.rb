class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :biens
  has_many :loyers, through: :biens

  after_create :send_welcome_email
  def sum_depenses_biens
    self.biens.map { |bien| bien.sum_depenses }.sum
  end

  def sum_loyers_biens
    self.biens.map { |bien| bien.sum_loyers }.sum
  end

  def cash_flow_biens
    cash_flow_biens_vrac = self.biens.map { |bien| bien.cash_flow_month }
    cash_flow_biens_clean = cash_flow_biens_vrac.transpose.map(&:sum)
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end


end
# Bien.third.depenses.where("date_paiement < ?", Date.today).count
# Bien.last.depenses.where("date_paiement ?", Date.today.beginning_of_month..Date.today.end_of_month).count

# Bien.first.depenses.where("date_paiement < ? AND date_paiement > ?", Date.today.beginning_of_month , Date.today.end_of_month).count


# Time.now.beginning_of_month + 1.month
