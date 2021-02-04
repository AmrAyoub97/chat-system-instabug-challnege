class ApplicationWorker
  include Sidekiq::Worker

  def perform(action, payload, old_app_id_to_be_updated = '')
    payload = JSON.parse(payload)
    case action
    when 'create'
      Application.create(payload)
    when 'update'
      application = Application.find_by_id(old_app_id_to_be_updated)
      application.update(payload)
    else
      nil
    end
  end
end