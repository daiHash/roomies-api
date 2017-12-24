class V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]

  def login
    authenticate params[:email], params[:password]
  end

  def test
    render json: {
          message: 'You have passed authentication and authorization test'
        }
  end
  # POST /register
  def register
    @user = User.create(user_params)
   if @user.save
    payload = { sub: @user.id, iss: "Roomies app", exp: 6.hours.from_now }
    @access_token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
    response = {
      access_token: @access_token,
      message: 'User created successfully'
    }
    render json: response, status: :created
   else
    render json: @user.errors, status: :bad
   end
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password
    )
  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
