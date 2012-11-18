	def full_title(page_title)
		base_title = "Ruby on Rails Tutorial Sample App"
		if(page_title.empty?)
			base_title
		else
			"#{base_title} | #{page_title}" # wykonujemy tutaj interpolacje stringow. wyluskujemy je. to to samo co base + " | + page
		end
	end
