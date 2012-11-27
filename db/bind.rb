

require 'rubygems'
#require 'active_record'

require File.expand_path('../../app/models/log', __FILE__)
class Binder

	DIVIDER = 3

	def initialize
		@partial_hash = Hash.new
	end


	def bind(id, cont)
		if @partial_hash[id] == nil
			@partial_hash[id]= [0, ""]
		end

		parametry = @partial_hash[id]
		counter = parametry[0]
		chain = parametry[1]
			
		if counter < DIVIDER
			chain = "#{chain}:#{cont}"
			counter = counter +1
			@partial_hash[id]=[counter,chain]
		else
			@log = Log.new
			@log.device_id = @device_id
			@log.content = chain
			@log.save
			chain = ""
			counter = 0
			@partial_hash[id]=[counter,chain]
		end
	end
end
