require "google_drive"
session = GoogleDrive::Session.from_config("config.json")

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
		@song = Song.find(params[:id])
		puts @song.id
		saveJson @song
		session = GoogleDrive::Session.from_config("config.json")

		# session.files.each do |file|
		#   puts file.title
		# end
		file = session.file_by_title("ascii.txt")
		file.download_to_file("#{Rails.root}/ascii.txt")

		# exec('/c/Users/henrypan/source/repos/dll/Debug/dll.exe')
		render json: {status: 'ok'}
	end

	def upload
		# puts params[:filename]
		puts params[:filename]
		session = GoogleDrive::Session.from_config("config.json")
		file = session.file_by_title(params[:filename])
		file.download_to_file("#{Rails.root}/ascii.txt")

		# exec('/c/Users/henrypan/source/repos/dll/Debug/dll.exe')
		render json: {status: 'ok'}
	end

	def saveJson(song)
		record_json = {
			"song" => song.notes,
			"mode" => song.mode,
			"bpm" => song.bpm.to_s
		} 
		File.open("#{Rails.root}/input.json", "w") do |f|
        	f.write(JSON.generate(record_json))
    	end 
    end

	private
	def file_params
		params.permit(:filename)
	end

	def song_params
		params.permit(:notes, :mode, :bpm, :name, :description, :length, :created_at)
	end
end
