class SongSerializer < ActiveModel::Serializer
  attributes :id, :notes, :mode, :bpm
end
