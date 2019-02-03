class CreateAnimes < ActiveRecord::Migration[5.0]
  def change
    create_table :animes do |t|
      t.string :title
      t.integer :anime_score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
