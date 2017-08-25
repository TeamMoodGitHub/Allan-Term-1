class CreateAnimes < ActiveRecord::Migration[5.1]
  def change
    create_table :animes do |t|
      t.string :title
      t.string :type
      t.text :synopsis
      t.string :genres
      t.integer :episodes
      t.string :aired
      t.string :licensors
      t.string :studios
      t.string :source
      t.string :duration
      t.string :rating
      t.text :openingtheme
      t.text :endingtheme
      t.string :mal

      t.timestamps
    end
  end
end
