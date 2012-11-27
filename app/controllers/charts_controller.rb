class ChartsController < ApplicationController
	  def get_data_from_c() 	
	  	respond_to do |format|
	  		# ZA Math.sin(params[:x].to_f).to_s PODAJEMY WLASCIWA WARTOSC TO WYKRESU RT
	  		#puts SimpleApp::Application::getDataFromDataAdapter(0.1) + "asdasdasdasdasdasdasdasd"
	  		# 
	  		# tmp = Math.sin(params[:x].to_f).to_s + ' ' + Math.cos(params[:x].to_f).to_s
			  format.html { render :text => SimpleApp::Application::getDataFromDataAdapter(params[:x].to_f).to_s }
			  #puts { render :text => Math.sin(params[:x].to_f).to_s}.to_s + "asdhalshjhgkjdfhkljdhfgkdhfskjgdfklsghldfkisg"
			end
	  end
	  
end
