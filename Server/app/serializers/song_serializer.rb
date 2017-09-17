class SongSerializer < ActiveModel::Serializer
  attributes :id, :notes, :mode, :bpm, :name, :description, :length, :created_at
end
