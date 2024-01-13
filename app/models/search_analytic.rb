class SearchAnalytic < ApplicationRecord
    include PgSearch::Model

    belongs_to :user
    belongs_to :article, optional: true
    validates :prompt, presence: true, length: { minimum: 2, maximum: 250 }

    def self.find_search_by_user(user, prompt)
      where(user: user, prompt: prompt).order(created_at: :desc)
    end

    def self.analytics_with_most_searched_prompt
      select('prompt, COUNT(prompt) as prompt_count')
        .group(:prompt)
        .order('prompt_count DESC')
    end

    def self.analytics_with_most_searched_article
      select('article_id, COUNT(article_id) as article_count')
        .group(:article_id)
        .order('article_count DESC')
    end

end
