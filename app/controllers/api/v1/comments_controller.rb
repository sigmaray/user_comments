class Api::V1::CommentsController < Api::V1::ApiController
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
    render json: { comments: @comments }
  end
end
