class AddUserIdToSearchAnalytics < ActiveRecord::Migration[7.1]
  def change
    add_reference :search_analytics, :user, null: false, foreign_key: true
  end
end
