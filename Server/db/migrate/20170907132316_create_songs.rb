class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
    	t.string :notes
    	t.string :mode
    	t.string :name
    	t.string :description
    	t.integer :length
    	t.datetime :activated
    	t.integer :bpm
		t.timestamps null: false
    end
  end
end
