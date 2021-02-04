class MessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform_new(app_id,chat_number, message_number,name)
    puts "SIDEKIQ WORKER GENERATING A REPORT FROM"
  end

  def perform_update(app_id,chat_number, message_number,name)
    puts "SIDEKIQ WORKER GENERATING A REPORT FROM"
  end

end