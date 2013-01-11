class ChartsController < ApplicationController
	  def get_data_from_c() 	
	  	respond_to do |format|
	  		# ZA Math.sin(params[:x].to_f).to_s PODAJEMY WLASCIWA WARTOSC TO WYKRESU RT
	  		#puts SimpleApp::Application::getDataFromDataAdapter(0.1) + "asdasdasdasdasdasdasdasd"
	  		# 
	  		# tmp = Math.sin(params[:x].to_f).to_s + ' ' + Math.cos(params[:x].to_f).to_s
			  format.html { render :text => SimpleApp::Application::getDataFromDataAdapter(params[:id].split("=")[1].to_i) }
			end
	  end
	  
	  def turnOn()
	    SimpleApp::Application::turnOnRtChart(params[:id].to_i)
	    format.html { render :text => "done" }
	  end
	  
	  def turnOff()
	    SimpleApp::Application::turnOffRtChart(params[:id].to_i)
	    format.html { render :text => "done" }
	  end

	  def index()
			#redirect_to "/charts?id=#{params[:id].to_s + ',' +params[:measure].to_s}"
		  device = Device.find(params[:id])
		  redirect_to "/charts?id=#{params[:id].to_s + ',' +device.dtype}"
		  
		  #render "charts/chart/"
    end
end
