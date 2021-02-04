class MessagesController < ApplicationController

  def show
    begin
      app_id = decoded_token
      if app_id != nil
        @messages = Message.find(application_id: app_id, chat_number: params[:chat_id]).as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @messages, status: 200
  end

  def index
    begin
      app_id = decoded_token
      if app_id != nil
        @messages = Message.find(application_id: app_id, chat_number: params[:chat_id], message_number: params[:id]).as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @messages, status: 200
  end

  def create
    begin
      app_id = decoded_token
      if app_id != nil
        @chat = Chat.find(application_id: app_id, chat_number: params[:id])
        @chat.chats_count += 1
        message_number = @chat.chats_count
        Message.create(message_number: message_number, application_id: app_id, chat_id: params[:id], body: message_params['body'])
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: { message_number: message_number }, status: 200
  end

  def search
    query = request.query_parameters['query']
    search_results = Message.search(query)
  end

  private

  def message_params
    params.permit(:body)
  end

end
