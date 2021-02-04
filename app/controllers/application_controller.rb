class ApplicationController < ActionController::API

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def auth_header
    # { X-Application-Token: 'Bearer <token>' }
    request.headers['X-Application-Token']
  end

  def decoded_token
    if auth_header
      token = auth_header
      begin
        decoded = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
        app_name = decoded[0]['app_name']
        application = Application.find_by_name(app_name)
        return { app_id: application.id, app_name: app_name }
      rescue JWT::DecodeError
        nil
      end
    else
      nil
    end
  end

end
