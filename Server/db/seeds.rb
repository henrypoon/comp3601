# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

songs = Song.create([
  {
    notes: '1|2#|0',
    mode: 'normal',
    bpm: 180
  },
  {
    notes: '32|2#|2',
    mode: 'normal',
    bpm: 120
  }])
