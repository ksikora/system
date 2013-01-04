class ReportsController < ApplicationController


  def index
		@reports = Report.all
		render 'index'
  end
  
  def destroy
  	@report = Report.find(params[:id])
  	@report.destroy
  	flash[:success] = "Deleted succesfully"
  	@reports = Report.all
  	render 'index'
  end

# koncepcja raportow: z zalozenia generowanie raportu powinno trwac bardzo dlugo, dlatego oprocz przycisku przy kazdym z devicea dodamy jeszcze zakladke "already generated reports" w ktorej bedzie mozna przegladnac poprzednio wygenerowane raporty.

  def  createandshow
  	
  	require 'descriptive_statistics'


  	deviceid = params[:id]	
  	@device = Device.find(deviceid)
  	@parameters_names = @device.dtype.split(',') # [height, width]
    @set = [[],[],[],[],[],[],[],[],[],[],[],[],[],[]]# tu chcemy uzyskac [[val11,val12,val13..], [val21,val22,val23....]..]
    
  	############## test
  	
  	#  @logs = @device.logs # zakomentuj to przy testach 
    
  	@logs = Log.find(:all, :conditions => {:device_id => deviceid})
  	#@logs = ["1.0,17.0,3.0:4.0,2.0,3.0", "2.0,2.0,3.0:1.0,2.0,3.0"] # Odkomentuj to przy testach
  	
  	@logs.each do |bindedlog| # log: val1,val2,val3:val1,val2,val3:...
  		unbinded_log_table = bindedlog.content.split(':')# [val1,val2,val3 , val1,val2,val3, ....  # zakomentuj to przy testach 
  		#unbinded_log_table = bindedlog.split(':') # Odkomentuj to przy testach
  		unbinded_log_table.each do |log|
  			values = log.split(',') #[val1,val2,val3]
  			i = 0
  			while i < values.length
  				@set[i].push(Float(values[i]))
  				i=i+1
  			end
  		end
  	end
  	#statistics{:standard deviations => [stdv11, stdv22, stdv3], means => [....]} koncepcja porzucona
  	
  	@report = Report.new(device_id: @device.id) ########## skoro jest kilka zmiennych dla jednego devicea a raport dotyczy devicea to np. pole standard_deviation bedzie mialo postac stdv1,stdv2 (csv po prostu)
  	
		i = 0
		while i < @parameters_names.length
		print @set[i]
			#stddev = @set[i].standard_deviation
			#print @set[i]
			@report.standard_deviation = "#{@report.standard_deviation}#{@set[i].standard_deviation},"# i nam mowi dla ktorej zmiennej
	  	@report.average = "#{@report.average}#{@set[i].mean},"
     i=i+1
  	end
		
		
		@report.parameters_name = @device.dtype
		@report.standard_deviation.chomp(',')
		@report.average.chomp(',')
		@report.save
		
		flash[:success] = "Report was generated succesfully"
		render 'show'
		
  end

	def show # pokaz juz istniejace raporty
		@report = Report.find(params[:id])
		@parameters_names = @report.parameters_name.split(',')
		#deviceid = @report.device_id	
  	#@device = Device.find(deviceid)
		render 'show' 
	end



end
