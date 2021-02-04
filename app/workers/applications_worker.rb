class ApplicationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform_new(app_id, name)
    puts "SIDEKIQ WORKER GENERATING A REPORT FROM"
  end

  def perform_update(app_id, name)
    puts "SIDEKIQ WORKER GENERATING A REPORT FROM"
  end

end