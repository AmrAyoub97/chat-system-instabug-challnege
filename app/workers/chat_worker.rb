class ChatWorker
  include Sidekiq::Worker

  def perform(chat_number, application_id)
    Chat.create(chat_number: chat_number, application_id: application_id)
  end
end