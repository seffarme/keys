class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :biens
  has_many :loyers, through: :biens

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
