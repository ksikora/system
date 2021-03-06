class DevicesController < ApplicationController
  # GET /devices
  # GET /devices.json

	

  def index
    @devices = Device.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @devices }
    end
  end

  def index_ordered_by_name
		if $name_order == nil
			$name_order = 0
		end

		if $name_order == 1		
	    @devices = Device.find(:all, order: 'name')
			$name_order = 0
		else
	    @devices = Device.find(:all, order: 'name DESC')
			$name_order = 1
		end

		render 'index'
	end


  def index_ordered_by_type
		if $type_order == nil
			$type_order = 0
		end

		if $type_order == 1		
	    @devices = Device.find(:all, order: 'dtype')
			$type_order = 0
		else
	    @devices = Device.find(:all, order: 'dtype DESC')
			$type_order = 1
		end

		render 'index'
	end

  def index_ordered_by_send
		if $send_order == nil
			$send_order = 0
		end

		if $send_order == 1		
	    @devices = Device.find(:all, order: 'sends_logs')
			$send_order = 0
		else
	    @devices = Device.find(:all, order: 'sends_logs DESC')
			$send_order = 1
		end

		render 'index'
  end

  def index_ordered_by_creation_time
		if $creat_order == nil
			$creat_order = 0
		end

		if $creat_order == 1		
	    @devices = Device.find(:all, order: 'created_at')
			$creat_order = 0
		else
	    @devices = Device.find(:all, order: 'created_at DESC')
			$creat_order = 1
		end

		render 'index'
  end



  # GET /devices/1
  # GET /devices/1.json
  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device }
    end
    #client = SimpleApp::Application::Sockets[@device.name]
    #client.puts 'dupa'
  end

  # GET /devices/new
  # GET /devices/new.json
  def new
    @device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render json: @device, status: :created, location: @device }
      else
        format.html { render action: "new" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.json
  def update
    @device = Device.find(params[:id])
    #devicename = @device.name
    respond_to do |format|
    	if @device.update_attributes(params[:device])
			#	if @device.sends_logs
	  	#		puts @device.name
    	#    client = SimpleApp::Application::Sockets[devicename] # wczesniejsza wersja z tutaj wyluskiwanym name nie dziala bo zwracalo nul
    	#    client.puts 'dupa'     	
    	#  end
    	  format.html { redirect_to @device, notice: 'Device was successfully updated.' }
    	  format.json { head :no_content }
    	else
    	  format.html { render action: "edit" }
    	  format.json { render json: @device.errors, status: :unprocessable_entity }
    	end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device = Device.find(params[:id])
    client = SimpleApp::Application::Sockets[@device.id]
    client.puts 'turnoff'  
    @device.destroy

    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end


  def activate
    @device = Device.find(params[:id])
    @device.update_attributes(:sends_logs => true)
    client = SimpleApp::Application::Sockets[@device.id]
    client.puts 'turnon'  
	  respond_to do |format|
    	format.html { redirect_to devices_path, notice: 'Device was successfully turned on.' }
			format.json { render json: @devices }
		end
  end

	def deactivate
    @device = Device.find(params[:id])
    @device.update_attributes(:sends_logs => false)
    client = SimpleApp::Application::Sockets[@device.id]
    client.puts 'turnoff'  
	  respond_to do |format|
    	format.html { redirect_to devices_path, notice: 'Device was successfully turned off.' }
			format.json { render json: @devices }
		end
	end




end
