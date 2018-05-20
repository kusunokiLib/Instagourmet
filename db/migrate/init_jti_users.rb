class AddTokenToUser < ActiveRecord::Migration[5.1]
  def change
    User.all.each { |user| user.update_column(:jti, SecureRandom.uuid) }
  end
end
