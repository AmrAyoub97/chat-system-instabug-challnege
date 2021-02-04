class Chat < ApplicationRecord
  belongs_to :application
  has_many :message
  trigger.after(:insert) do
    "UPDATE applications SET chat_count = chat_count + 1 WHERE id = NEW.application_id;"
  end
  def self.MESSAGE_COUNT_REDIS_KEY
    "chat_message_count_#{self.id}"
  end
end
