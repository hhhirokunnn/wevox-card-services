# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
