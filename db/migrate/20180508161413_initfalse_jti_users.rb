class InitfalseJtiUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :jti, false
  end
end
