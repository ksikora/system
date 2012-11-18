module UsersHelper
	
	# zwraca nam grawatar(jakis tam kurwa asci art wyliczanny na podstawie maila, ten grawatar dostarcza nam obca strona
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar" )
	end
end
