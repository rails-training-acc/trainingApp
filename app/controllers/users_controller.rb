class UsersController < ApplicationController

   before_filter :signed_in_user, only: [:edit, :update]


  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def search
    @users = User.search params[:search]
  end

  private

    def signed_in_user
      redirect_to signin_url, notice: "Please, sign in" unless sign_in?
    end

end
