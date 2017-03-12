class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :place_id
      t.integer :user_id
      t.text :context

      t.timestamps null: false
    end
  end
end
