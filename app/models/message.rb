class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat
  trigger.after(:insert) do
    "UPDATE chats SET messages_count = messages_count + 1 WHERE id = NEW.chat_id;"
  end

  settings do
    mappings dynamic: false do
      indexes :message_number, type: :long
      indexes :chat_number, type: :long
      indexes :body, type: :text, analyzer: 'english'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          query_string: {
            query: '*' + query.to_s + '*',
            fields: ['body']
          }
        }
      }
    )
  end

end
