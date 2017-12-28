class V1::ProfilesController < ApplicationController
   before_action :check_profile_presence, only: [:new, :create]

   # def index
   #   @profiles = Profile.all
   #   render json: {status: 'Success', message: 'Loaded profiles', data: @profiles}, status: :ok
   # end

  def show
    @user = User.find_by(id: params[:id])
    @profile = Profile.joins(:user).where(:profiles => { :user_id => @user.id })

    render json: {status: 'Success', message: 'Loaded profile', data: @profile}, status: :ok
  end

  def create
    @profile = current_user.profiles.create(profile_params)
    if @profile.save
      render json: {status: 'Success', message: 'Saved profile', data: @profile}, status: :created
    else
      render json: {status: 'Error', message: 'Profile not saved', data: @profile.errors}, status: 400
    end
  end

  private

  def profile_params
    params.permit(:age, :description, :occupation, :is_smoker, :nationality)
  end

  def check_profile_presence
    render json: {
          message: 'You already have a profile'
        } if current_user.profiles.exists?
  end
end
