class MakeArticleIdNullableInSearchAnalytics < ActiveRecord::Migration[7.1]
  def change
    change_column :search_analytics, :article_id, :integer, null: true
  end
end
