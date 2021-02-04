class ApplicationWorker
  include Sidekiq::Worker

  def perform(action, payload)
    puts payload
    case action
    when 'create'
      Application.create(payload[:application])
    when 'update'
      application = Application.find_by_name(payload['name'])
      application.update(payload)
    else
      nil
    end
  end
end