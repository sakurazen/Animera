class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :episode_no
      t.integer :episode_score
      t.text :comment
      t.references :user, foreign_key: true
      t.references :anime, foreign_key: true

      t.timestamps
    end
  end
end
