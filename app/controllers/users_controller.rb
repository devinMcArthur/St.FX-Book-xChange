class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def index
    @users = User.paginate(page: params[:page]).order("created_at DESC")
  end

  def show
    @user  = User.find(params[:id])
    if logged_in?
      @book  = current_user.books.build
      @demand = current_user.demands.build
    end
    @books = @user.books.paginate(page: params[:page])
    @demands = @user.demands.paginate(page: params[:page])
  end

  def new
    if logged_in?
      redirect_to(current_user)
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your Account has successfully been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

  def prompt
    @book = current_user.books.build
    @demand = current_user.demands.build
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def book_params
      params.require(:book).permit(:title)
    end

    def demand_params
      params.require(:demand).permit(:title)
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
