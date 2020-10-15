class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.text :content
      t.string :picture
      t.references :user, foreign_key: true
    end
  end
end
