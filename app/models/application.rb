class Application < ApplicationRecord
  has_many :chat
  validates :name, presence: true, uniqueness: true
end
