module UsersHelper
 def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

 private 
 def user_param
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end

end
