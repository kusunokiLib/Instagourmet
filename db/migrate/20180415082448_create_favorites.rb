class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.string :user_id
      t.string :post_id

      t.timestamps
    end
  end
end
