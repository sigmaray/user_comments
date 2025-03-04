class Api::V1::UsersController < Api::V1::ApiController
  def index
    @users = User.all
    # TODO: Decrease amount of SQL queries
    users_json = @users.map do |user|
      json = user.as_json
      json[:comment_count] = user.comments.count
      json
    end
    render json: { users: users_json }
  end
end
