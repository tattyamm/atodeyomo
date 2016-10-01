class PagesController < ApplicationController
	protect_from_forgery except: :index
	skip_after_action :verify_same_origin_request


	def index
	end

	def core
		@password = params[:pw]
		respond_to do |format|
			format.js { render :content_type => 'text/javascript', :layout => false}
			format.html {}
		end
	end

end
