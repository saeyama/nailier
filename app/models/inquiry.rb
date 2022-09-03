# frozen_string_literal: true

class Inquiry < ApplicationRecord
  validates :title, presence: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :description, presence: true
end
