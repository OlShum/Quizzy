class Api::RoomController < Api::ApplicationController
  def index
    puts @question
      ActionCable.server.broadcast 'quizzroom_channel', @question.as_json.to_json
    head :ok
  end
end
