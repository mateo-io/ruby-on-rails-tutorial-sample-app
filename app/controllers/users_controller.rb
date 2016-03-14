class UsersController < ApplicationController

  include UsersHelper
  before_action :logged_in_user, only: [:index,:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only:[:destroy]
  
  def index
    @users=User.paginate(page: params[:page])
  end

  def show
  	@user=User.find(params[:id])
  	
  end

  def new
  	@user=User.new
  end
  
  def edit
  end

  def create
  	@user=User.new(user_param)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def update
    if @user.update_attributes(user_param)
      flash[:success]= "Account has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]= "User deleted"
    redirect_to users_path
  end


end
