require 'thread'

class RealTimeDataAdapter
	
	def initialize
		@deviceList = Hash.new	
		@mutex = Mutex.new
	end
	
#	def processData(arg)
#		arr = arg.split(',')
#		@mutex.synchronize do
#			if not @deviceList.has_key?(arr[0])
#				queue = Array.new 
#				queue << arr[1..arr.length-1].join(',')
#				@deviceList.store(arr[0],queue)
#			else
#				@deviceList.fetch(arr[0]) << arr[1..arr.length-1].join(',')
#				if @deviceList.fetch(arr[0]).length == 21
#					@deviceList.fetch(arr[0]).delete_at(0)
#					@deviceList.fetch(arr[0]).compact!
#				end
#			end
#		end
#		puts @deviceList.to_s
#	end


	def processData(arg)
		arr = arg.split(',')
		@mutex.synchronize do
			if not @deviceList.has_key?(arr[0])
				@deviceList.store(arr[0],arr[1..arr.length-1].join(','))
			else
				@deviceList.delete(arr[0])
				@deviceList.store(arr[0],arr[1..arr.length-1].join(','))
			end
		end
		puts @deviceList.to_s
	end
	
	def getData(device)
		@mutex.synchronize do
			if not @deviceList.has_key?(device)
				return 'no_data_found'
			end
			@deviceList.fetch(device)
		end
	end
	
end



tmp = RealTimeDataAdapter.new
tmp.processData('wacek,asd,1,2,3,4,1')
puts tmp.getData('wacek')
puts tmp.getData('wacek2')
