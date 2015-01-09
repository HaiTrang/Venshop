class UsersController < ApplicationController
  include Product::Controller
  before_action :list_categories, only: [:new, :edit, :show, :index, :update]
  before_action :find_user, only: [:edit, :show, :correct_user, :update, :destroy]  
  
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user,  only: :destroy

  def show    
    
  end  
  
  def new
  	 @user = User.new    
  end

  def create    
    @user = User.new(user_params)
    if @user.save
      log_in @user      
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  def edit    
    
  end

# khong the update duoc, vao else
  def update
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
    @user.destroy
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
