class AddArticleIdToSearchAnalytics < ActiveRecord::Migration[7.1]
  def change
    add_reference :search_analytics, :article, null: false, foreign_key: true
  end
end
