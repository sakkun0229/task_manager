class UsersController < ApplicationController
  before_action :ensure_correct_user,{only:[:edit,:update]}

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "You don't have authority"
      redirect_to("/")
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render "edit"
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Login Successful"
      redirect_to("/")
    else
      @error_message = "The User does not exist"
      render "login_form"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logout Completed"
    redirect_to("/")
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :admin)
    end


end
