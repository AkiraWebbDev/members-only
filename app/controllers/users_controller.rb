class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Log the user in
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
