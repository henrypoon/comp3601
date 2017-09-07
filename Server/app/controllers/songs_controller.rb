class SongsController < ApplicationController
	def show
		@song = Song.find(params[:id])
		render json: @song
	end

	def index
		render json: Song.all
	end

	def create
		@song = Song.new(song_params)
		if @song.save
			render json: @song
		else
			render json: {status: 'ERROR'}
		end
	end

	def destroy
		@song = Song.find(params[:id])
		@song.destroy
	end


	def play
		system('echo fuck')
		render json: Song.all
	end

	private
	def song_params
		params.permit(:notes, :mode, :bpm)
	end
end
