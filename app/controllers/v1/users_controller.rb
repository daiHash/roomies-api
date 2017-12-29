class V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]

  def login
    authenticate(login_params[:email], login_params[:password])
  end

  # Register a new User
  def register
    @user = User.create(user_params)
   if @user.save
    response = { message: 'User created successfully' }
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

  def login_params
    params.permit(:email, :password)
  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      payload = { user_id: command.result }
      render json: {
        access_token: JsonWebToken.encode(payload),
        refresh_token: JsonWebToken.encode(payload, 6.hours.from_now + (3600 * 24 * 10)),
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
