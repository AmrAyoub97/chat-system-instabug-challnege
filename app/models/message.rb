class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat
  trigger.after(:insert) do
    "UPDATE chats SET message_count = message_count + 1 WHERE id = NEW.chat_id;"
  end

  settings do
    mappings dynamic: false do
      indexes :message_number, type: :long
      indexes :chat_id, type: :long
      indexes :body, type: :text, analyzer: 'english'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        size: 20,
        query: {
          query: query,
          fields: %w[body]
        }
      }
    )
  end

  def as_indexed_json(options = nil)
    self.as_json( only: [ :message_number, :chat_id, :body ] )
  end
end
