class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Cool we can do something 
    else
      # handle exception condition
      flash[:error] = "Invalid password or username"
      render 'new'
    end
  end

  def destroy
  end
end
