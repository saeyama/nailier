# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :designs, dependent: :destroy

  validates :account_name, presence: true, uniqueness: true
  validates :agreement_terms, acceptance: true, on: :create
end
