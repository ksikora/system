require File.expand_path('../boot', __FILE__)
#require File.expand_path('../../db/bind', __FILE__) # zalaczamy binder


# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
require "beanstalk-client"
# require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test))) # 						laduje gemy
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module SimpleApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'


############## binder ############
  	require 'socket'



		DIVIDER = 50
		Partial_logs = Hash.new

		def binder()

			soc = UDPSocket.new
			soc.bind("127.0.0.1",210021)


			puts 'UDP for binder successfuly binded'

			#c = Thread.new {testbinder} # usuniecie tego odpala test
				
			loop do
				#puts 'odebrano dane'

			
				id = soc.recv(10000)
				cont = soc.recv(10000)

				if Partial_logs[id] == nil
					Partial_logs[id]= [0, ""]
				end

				parametry = Partial_logs[id]
				counter = parametry[0]
				chain = parametry[1]
			
				if counter < DIVIDER
					chain = "#{chain}:#{cont}"
					counter = counter +1
					Partial_logs[id]=[counter,chain]
				else
					puts 'wale do bazy'
					@log = Log.new
					@log.device_id = @device_id
					@log.content = chain
					@log.save
					chain = ""
					counter = 0
					Partial_logs[id]=[counter,chain]
				end
			end
		end


		b = Thread.new {binder}


########## test binder ################
def testbinder
		soc2 = UDPSocket.new
		soc2.connect("127.0.0.1",210021)

		puts "dupa"

		sleep 4
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		soc2.send "1", 0
		soc2.send "aaaaa", 0

end

################ konfiguracja servera 
		
    require 'socket'
    Sockets=Hash.new
    
    @myDataAdapter = nil
    



    #$threads = [] # tablica hashy postaci nazwawatku => referencja do watku
    #threads = [ "watek" ] 
    
    def getDataFromDataAdapter(x)
      if @myDataAdapter == nil
        @myDataAdapter = RealTimeDataAdapter.new
      end
        return @myDataAdapter.getData(x)
    end
    
    def sendDataToDataAdapter(x)
      if @myDataAdapter == nil
        @myDataAdapter = RealTimeDataAdapter.new
      end
      return @myDataAdapter.processData(x)
    end
    
    
    def runserv
################ Obiekt do przekazywanai danych do gui  
      #file = File.open '../log/tcpserver.log', 'a'
      #file = File.new 'dupa.log', 'w'
      server = TCPServer.new 21001 

      #file.puts 'server initialized'
      puts 'server initialized'
      b = Thread.new {runBeanstalkdDataReceiver}
      loop do
				Thread.start(server.accept) do |client|
					name = client.gets
					dtype = client.gets
					hash = Hash[name: name, dtype: dtype, sends_logs: false]
					puts hash
					@device = Device.new(hash) 
					
					@device.save
					puts 'device saved to database'
					Sockets[@device.id]=client
					client.puts @device.id
#					close = client.gets
	#				if close == "close"
		#				Socket.reject! { |k| k==@device.id }
			#		end
				#	if close == "close\n"
				#		Socket.reject! { |k| k==@device.id }
				#	end


				end
      end
    end	

    a = Thread.new {runserv}

############## koniec konfiguracj servera tcp
   def runBeanstalkdDataReceiver
      beanstalk = Beanstalk::Pool.new(['127.0.0.1:12348'])
      puts 'bs connceted'
      loop do
        job = beanstalk.reserve
        sendDataToDataAdapter(job.body)
      end
    end



############## koniec konfiguracj servera tcp #############

############## usuwanie nieuzywanych socketow #################


  end
  
############## obiekt przekazujacy rt dane do controllera
  

  class RealTimeDataAdapter
    require 'thread'
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
	    arr = arg.split(':')
	    @mutex.synchronize do
		    if not @deviceList.has_key?(arr[0])
			    @deviceList.store(arr[0],arr[1..arr.length-1].join(' '))
		    else
			    @deviceList.delete(arr[0])
			    @deviceList.store(arr[0],arr[1..arr.length-1].join(' '))
		    end
	    end
    end

    def getData(device)
	    @mutex.synchronize do
		    if not @deviceList.has_key?(device.to_s)
		      puts 'walke' + device.to_s + " " + @deviceList.to_s
			    return '0.0'
		    end
		    @deviceList.fetch(device.to_s)
	    end
    end

  end
  
  
############## obiekt przekazujacy rt dane do controllera - koniec


############## BEANSTALKD receiver  
    
    
    
end

