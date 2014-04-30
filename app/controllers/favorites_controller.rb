class FavoritesController < ApplicationController
	def index
		@favorites = Favorite.all

	def new
		@favorite = Favorite.new(event: cookies[:name])
	end

end
