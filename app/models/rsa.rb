class Rsa < ApplicationRecord
  has_many :encrypt_messages
  has_many :decrypt_messages
end
