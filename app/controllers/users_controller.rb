class UsersController < ApplicationController

  include UsersHelper
  
  def index
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
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def update
  end

  def delete
  end


end
