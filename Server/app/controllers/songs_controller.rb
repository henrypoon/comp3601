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

	def update
		@song = Song.find(params[:id])
		if @song.update(song_params)
			render json: @song
		else
			render json: {status: 'ERROR'}
		end
	end

	def play
		system('cd ../Python ; python jsonToAscii.py')
		render json: {status: 'ok'}
	end

	private
	def song_params
		params.permit(:notes, :mode, :bpm, :name, :description, :length, :created_at)
	end
end
