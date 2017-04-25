class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable, :rememberable, :trackable#, :recoverable

  has_one :cart
  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
end
