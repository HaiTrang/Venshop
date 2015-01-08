class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @catagories = Catagory.all
  end  
  
  def new
  	 @user = User.new
     @categories = Category.all
  end
  def create
    puts "tao users moi----------------------------"
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Venshop!"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def edit
    @user = User.find(params[:id])
    @catagories = Catagory.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to user_path
    else
      render 'edit'
    end
  end
  def index
    @users = User.paginate(page: params[:page],per_page: 10)
    
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
      	store_location        
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  private
  def user_params
     params.require(:user).permit(:name, :email, :password , :password_confirmation)
  end
  # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
