class Api::V1::UsersController < Api::V1::ApiController
  def index
    users = User.page(params[:page]).per((params[:per_page] || default_per_page).to_i).order('id ASC')

    # TODO: Decrease amount of SQL queries
    users_json = users.map do |user|
      json = user.as_json
      json[:comment_count] = user.comments.count
      json
    end

    render json: {      
      count: User.count,
      current_page: users.current_page,
      total_pages: users.total_pages,
      per_page: users.limit_value,
      items: users_json,
    }
  end
end
