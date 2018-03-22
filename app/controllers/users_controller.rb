class UsersController < ApplicationController

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

end
