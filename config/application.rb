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


		DIVIDER = 3
		Partial_logs = Hash.new
  def runBeanstalkdDataReceiver
  
      #def runBeanstalkdRTDataReceiver  
#      beanstalk = Beanstalk::Pool.new(['127.0.0.1:12348'])
#      loop do
##        begin
#          job = beanstalk.reserve
#          sendDataToDataAdapter(job.body)
#          puts job.body
#        rescue
#          beanstalk = Beanstalk::Pool.new(['127.0.0.1:12348'])
#          puts 'exception caught'      
#        end
 #     end
#    end
  
  

      beanstalk = Beanstalk::Pool.new(['127.0.0.1:92349'])
      puts 'starting data receiver' + beanstalk.to_s
      #sock = UDPSocket.new
      #sock.connect("127.0.0.1",210021)
      loop do
        job = beanstalk.reserve
        #id =  job.body.split(',')[0]
        #message = job.body.split(',')[1..-1].join(',')
        #puts id + ' ' + message
        #sock.send id, 0
        #sock.send job.body, 0
        #puts 'sent'
        
        msg = job.body
        job.delete
        id = msg.split(',')[0]
			  cont = msg.split(',')[1..-1].join(',').split(/\n/)[0]
			  #puts "#{cont} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
				#id = soc.recv(10000)
				#cont = soc.recv(10000)
        
				if Partial_logs[id] == nil
					Partial_logs[id]= [0, ""]
				end
				parametry = Partial_logs[id]
				counter = parametry[0]         # ile porcji danych
				chain = parametry[1]					 # dotychczasowe dane
			 	if counter < DIVIDER
					chain = "#{chain}:#{cont}" ############# log postaci jest aaaa:aaaa:aaaa:aaaa
					counter = counter +1
					Partial_logs[id]=[counter,chain]
				else
					#puts 'wale do bazy'
					
				  @log = Log.new
				  #puts e.inspect
				  #puts e.backtrace
					#puts 'LOG NEW'
					@device_id=id
					@log.device_id = @device_id
					#puts 'znam device id'
					@log.content = "#{chain}:#{cont}"
					puts @log.content
					@log.save
					chain = ""
					counter = 0
					Partial_logs[id]=[counter,chain]
				end
      end
      
      
      
      
    end
    
    
    
    
    
    
    
    
		def binder()

			soc = UDPSocket.new
			soc.bind("127.0.0.1",210021)


			puts 'UDP for binder successfuly binded'

			#c = Thread.new {testbinder} # usuniecie tego odpala test
			
			loop do
				#puts 'odebrano dane'

			  msg = soc.recv(10000)
			  id = msg.split(',')[0]
			  cont = msg.split(',')[1..-1].join(',').split(/\n/)[0]
			  #puts "#{cont} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
				#id = soc.recv(10000)
				#cont = soc.recv(10000)

				if Partial_logs[id] == nil
					Partial_logs[id]= [0, ""]
				end

				parametry = Partial_logs[id]
				counter = parametry[0]         # ile porcji danych
				chain = parametry[1]					 # dotychczasowe dane
			 	if counter < DIVIDER
					chain = "#{chain}:#{cont}" ############# log postaci jest aaaa:aaaa:aaaa:aaaa
					counter = counter +1
					Partial_logs[id]=[counter,chain]
				else
					puts 'wale do bazy'
					@log = Log.new
					@log.device_id = @device_id
					@log.content = "#{chain}:#{cont}"
					#puts @log.content
					@log.save
					chain = ""
					counter = 0
					Partial_logs[id]=[counter,chain]
				end
			end
		end


########## test binder ################
def testbinder
		soc2 = UDPSocket.new
		soc2.connect("127.0.0.1",210021)


		sleep 4
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0
		sleep 1
		soc2.send "1", 0
		soc2.send "aaaaa", 0

end

################ konfiguracja servera ################
		
    require 'socket'
    Sockets=Hash.new
    
    @myDataAdapter = nil
    @myRTswitch = nil    




    #$threads = [] # tablica hashy postaci nazwawatku => referencja do watku
    #threads = [ "watek" ] 
    
    
################ wlaczanie i wylaczanie RT ################
     def turnOnRtChart(x)
       if @myRTswitch == nil
          @myRTswitch = RTswitch.new  
       end
       @myRTswitch.turnOn(x)

     end
    
     def turnOffRtChart(x)
       if @myRTswitch == nil
          @myRTswitch = RTswitch.new  
       end
       @myRTswitch.turnOff(x)
     end
    
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
      @myDataAdapter.processData(x)
    end
################ Obiekt do przekazywanai danych do gui 
    def runserv
			f = open('./log/tcpserver.log','w')
      server = TCPServer.new 21001 

      line= "server initialized\n"
      puts line
			f.write("#{Time.new}:		")
			f.write(line)
      
      loop do
				Thread.start(server.accept) do |client|
					name = client.gets.chop
					dtype = client.gets.chop
					hash = Hash[name: name, dtype: dtype, sends_logs: false]
					puts hash
					@device = Device.new(hash) 
					
					@device.save
					f.write("#{Time.new}:		")			
					line =  "device with id: #{@device.id} saved to database\n"
					f.write(line)
					puts line
					Sockets[@device.id]=client
					client.puts @device.id

					close = client.gets
						Sockets.delete @device.id
						f.write("#{Time.new}:		")		
						line =  "device with id: #{@device.id} has disconnected from system\n"
						f.write(line)					
						@device.destroy
				end
      end
    end	



############## koniec konfiguracj servera tcp
   def runBeanstalkdRTDataReceiver  
      beanstalk = Beanstalk::Pool.new(['127.0.0.1:12348'])
      loop do
        begin
          job = beanstalk.reserve
          sendDataToDataAdapter(job.body)
          job.delete
        rescue
          beanstalk = Beanstalk::Pool.new(['127.0.0.1:12348'])
          puts 'exception caught'      
        end
      end
    end



############# init threads #################################

    a = Thread.new {runserv}
		#b = Thread.new {binder}
		d = Thread.new {runBeanstalkdDataReceiver}
		sleep(1)
    c = Thread.new {runBeanstalkdRTDataReceiver}
    
    



############## koniec konfiguracj servera tcp #############

############## usuwanie nieuzywanych socketow #################


  end

############## obiekt aktywujacy i wylaczajacy rt
  class RTswitch
  
    def initialize
      @deviceWatchers = Hash.new
    end
    
    def turnOn(x)
      
      if not @deviceWatchers.has_key?(x)
        @deviceWatchers.store(x,0)
      end
      
      @deviceWatchers[x] = @deviceWatchers[x]+1
      puts @deviceWatchers[x]
      begin
        f = open('plik.tmp')
        line = f.readline
      rescue
        line = ""
      end
      begin
        File.delete(f)
      rescue
      
      end
      if not line.split(' ').include?(x.to_s)
        line = line + ' ' + x.to_s 
      end
      f = open('plik.tmp','w')
      f.write(line)
      f.close
    end
    
    def turnOff(x)
      if @deviceWatchers[x] == 1
        begin
          f = open('plik.tmp')
          line = f.readline
        rescue
          line = ""
        end

        begin
          File.delete(f)
        rescue

        end
        if line.split(' ').include?(x.to_s) 
          tmp = line.split(' ')
          tmp.delete(x.to_s)
          line = tmp.join(' ')
        end
        f = open('plik.tmp','w')
        f.write(line)
        f.close
      end
      @deviceWatchers[x] = @deviceWatchers[x]-1
    end
  
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
    puts arg
	    arr = arg.split(',')
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

