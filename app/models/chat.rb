class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages

  trigger.after(:insert) do
    "UPDATE applications SET chat_count = chat_count + 1 WHERE id = NEW.application_id;"
  end

  def self.MESSAGE_COUNT_REDIS_KEY(app_name, chat_number)
    "chat_message_count_#{app_name}_#{chat_number}"
  end
end
