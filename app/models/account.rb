class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :contacts, dependent: :destroy

  validates :name, presence: true
end
