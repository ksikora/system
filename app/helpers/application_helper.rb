module ApplicationHelper
	
	def full_title(page_title)
		base_title = "System to gather and visualise remote data"
		if(page_title.empty?)
			base_title
		else
			"#{base_title} | #{page_title}" # wykonujemy tutaj interpolacje stringow. wyluskujemy je. to to samo co base + " | + page
		end
	end

end
