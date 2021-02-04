class ChatsController < ApplicationController

  def show
    begin
      token = decoded_token
      if token != nil
        app_name = token[0]['app_name']
        @application = Application.find_by(name: app_name)
        @chats = Chat.find(application_id: @application.id, chat_number: params[:id]).as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @chats, status: 200
  end

  def index
    begin
      token = decoded_token
      if token != nil
        app_name = token[0]['app_name']
        @application = Application.find_by(name: app_name)
        @chats = Chat.find(application_id: @application.id).as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @chats, status: 200
  end

  def create
  end

  def update
  end

end
