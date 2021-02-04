class Application < ApplicationRecord
  has_many :chat
  validates :name, presence: true, uniqueness: true
  def self.CHAT_COUNT_REDIS_KEY
    "application_chat_count_#{self.name}"
  end
end
