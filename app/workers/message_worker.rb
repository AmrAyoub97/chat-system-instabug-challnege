class MessageWorker
  include Sidekiq::Worker

  def perform(body, message_number, chat_number, application_id)
    Message.create(body: body, message_number: message_number, chat_number: chat_number, application_id: application_id)
  end
end