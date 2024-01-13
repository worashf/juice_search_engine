require 'rails_helper'

RSpec.describe SearchAnalyticsHelper, type: :model do
    describe 'Testing search_analytiics features' do


        let!(:user) { User.create(name: 'Test User', ip_address: '192.168.3.1') }
        let!(:article) { Article.create(title: 'Test Article', body: 'Test Body one') }

        describe 'Find search by user' do
            it 'returns search analytics with the given user and prompt' do
              SearchAnalytic.create(user: user, prompt: 'Test Prompt 1')
              SearchAnalytic.create(user: user, prompt: 'Test Prompt 2')

              results = SearchAnalytic.find_search_by_user(user, 'Test Prompt 1')
              expect(results.length).to eq(1)
              expect(results.first.prompt).to eq('Test Prompt 1')
            end

          end

          describe 'Analytics with most searched prompt' do
            it 'returns search analytics with the most searched prompts in descending order' do
              SearchAnalytic.create(user: user, prompt: 'Test Prompt 1')
              SearchAnalytic.create(user: user, prompt: 'Test Prompt 2')
              SearchAnalytic.create(user: user, prompt: 'Test Prompt 2')

              results = SearchAnalytic.analytics_with_most_searched_prompt
              expect(results.first.prompt).to eq('Test Prompt 2')
              expect(results.first.prompt_count).to eq(2)
            end
          end

          describe 'Analytics with_most searched article' do
            it 'returns search analytics with the most searched articles in descending order' do
              SearchAnalytic.create(user: user, prompt: 'Test Prompt', article: article)
              SearchAnalytic.create(user: user, prompt: 'Test Prompt', article: article)
              SearchAnalytic.create(user: user, prompt: 'Test Prompt')

              results = SearchAnalytic.analytics_with_most_searched_article
              expect(results.first.article_id).to eq(article.id)
              expect(results.first.article_count).to eq(2)
            end
          end

    end


end

