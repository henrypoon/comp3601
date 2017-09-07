class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
    	t.string :notes
    	t.string :mode
    	t.integer :bpm
		t.timestamps null: false
    end
  end
end
