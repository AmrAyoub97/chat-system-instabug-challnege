class ChatWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform_new(app_id, chat_number)
    puts "SIDEKIQ WORKER GENERATING A REPORT FROM"
  end

end