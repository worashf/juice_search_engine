class CreateSearchAnalytics < ActiveRecord::Migration[7.1]
  def change
    create_table :search_analytics do |t|
      t.string :prompt

      t.timestamps
    end
  end
end
