module UsersHelper


 def gravatar_for(user, options={size:80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

 private 
 def user_param
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end



 def correct_user
 	@user=User.find(params[:id])
 	redirect_to(root_url) unless current_user?(@user)
 end

def admin_user
	redirect_to(root_url) unless current_user.admin?
end




end
