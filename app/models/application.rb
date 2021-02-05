class Application < ApplicationRecord
  has_many :chats
  has_many :messages, through: :chats
  validates :name, presence: true, uniqueness: true

  def self.CHAT_COUNT_REDIS_KEY(app_name)
    "application_chat_count_#{app_name}"
  end
end
