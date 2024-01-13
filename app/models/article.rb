class Article < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_full_text, against: [:search_vector],
  using: {
    tsearch: {
      tsvector_column: "search_vector",
      dictionary: "english"
    }
  }

  has_many :search_analytics, class_name: 'SearchAnalytic'
  validates :title, presence: true, length: { maximum: 250 }
  validates :body, presence: true, length: { maximum: 1000 }
end
