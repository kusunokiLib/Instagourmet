class ChangeDatatypeUserIdOfFavorites < ActiveRecord::Migration[5.1]
  def change
    #change_column :favorites, :user_id, 'integer USING CAST(user_id AS integer)'
    #change_column :favorites, :post_id, 'integer USING CAST(post_id AS integer)'
  end
end
