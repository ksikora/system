class ChartsController < ApplicationController
	  def get_data_from_c() 	
	  	respond_to do |format|
	  		# ZA Math.sin(params[:x].to_f).to_s PODAJEMY WLASCIWA WARTOSC TO WYKRESU RT
	  		
	  		# 
			  format.html { render :text => (Math.sin(params[:x].to_f).to_s)}
			  #puts { render :text => Math.sin(params[:x].to_f).to_s}.to_s + "asdhalshjhgkjdfhkljdhfgkdhfskjgdfklsghldfkisg"
			end
	  end
	  
end
