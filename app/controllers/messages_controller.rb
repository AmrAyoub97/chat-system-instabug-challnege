class MessagesController < ApplicationController

  def show
    begin
      application = decoded_token
      if application != nil
        @chats = Chat.find(application_id: application[:app_id], chat_number: params[:id]).as_json(:except => :id)
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
      application = decoded_token
      if application != nil
        @chats = Application.find_by(id: application['app_id']).chats.as_json(:except => :id)
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
    begin
      application = decoded_token
      if application != nil
        chat_number = $redis.incr(Application.CHAT_COUNT_REDIS_KEY(application[:app_name]))
        ChatWorker.perform_async(chat_number: chat_number, application_id: application[:app_id])
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: { chat_number: chat_number }, status: 200
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
