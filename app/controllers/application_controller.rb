class ApplicationController < ActionController::Base

	def getUrl
		scheme = request.ssl? ? "https" : "http"
		scheme + "://" + request.host_with_port
	end

end
