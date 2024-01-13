class SearchAnalyticsController < ApplicationController


    def index
      @user = current_user
      @user_prompts = user_prompts
      @most_searched_term = SearchAnalytic.analytics_with_most_searched_prompt
      @most_searched_articles = SearchAnalytic.analytics_with_most_searched_article
      p @user_prompts
      @most_searched_term.each do |analytics|
        puts "Prompt: #{analytics.prompt}, Count: #{analytics.prompt_count}"
      end
    end

    private

    def current_user
      User.find_or_create_by(ip_address: request.remote_ip) do |user|
        user.name = Faker::Name.name
      end
    end

    def user_prompts
      SearchAnalytic.group(:prompt).order(count: :desc).count
    end
  end
