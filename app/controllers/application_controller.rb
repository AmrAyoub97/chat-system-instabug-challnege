class ApplicationController < ActionController::API

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def auth_header
    request.headers['x-app-token']
  end

  def decoded_token
    if auth_header == nil
      raise 'Invalid Token'
    end
    token = auth_header
    begin
      decoded = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
      if decoded[0]['app_name'] == nil
        raise JWT::DecodeError
      end
      app_name = decoded[0]['app_name']
      application = Application.find_by_name!(app_name)
      return { app_id: application.id, app_name: app_name }
    rescue
      nil
    end
  end
end
