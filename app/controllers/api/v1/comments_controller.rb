class Api::V1::CommentsController < Api::V1::ApiController
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
    render json: { comments: @comments }
  end

  def index
    user = User.find(params[:user_id])
    comments = user.comments.page(params[:page]).per((params[:per_page] || default_per_page).to_i).order('id ASC')
    render json: {      
      count: user.comments.count,
      current_page: comments.current_page,
      total_pages: comments.total_pages,
      limit_value: comments.limit_value,
      items: comments
    }
  end
end
