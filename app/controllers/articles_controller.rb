class ArticlesController < ApplicationController
  include StringMatcher

  def index
    @prompt = search_param

    if @prompt.present?
      @articles = Article.search_full_text(@prompt)

      create_search_prompt if should_create_search_prompt?
    else
      @articles = Article.all
    end

    @articles  = @articles.paginate(per_page: 10, page: params[:page])

  end

  private


  def create_search_prompt
    @result = get_last_search
    @latest_prompt = @result[:last_search]
    @prompt = search_param
    @user = get_user

    if should_create_prompt_creation?(@latest_prompt, @prompt)
      SearchAnalytic.create!(user: @user, article: @result[:article], prompt: @prompt)
    else
      @latest_prompt[:last_search].update(user: @user, article: @result[:article], prompt: @prompt)
    end
  end

  def should_create_prompt_creation?(latest_prompt, prompt)
    get_last_search[:last_search].blank? || !same_strings?(latest_prompt&.prompt, prompt)
  end

  def get_last_search
    @last_search ||= SearchAnalytic.find_search_by_user(get_user, search_param).first
    @article = @last_search&.prompt.present? ? Article.search_full_text(@last_search.prompt) : nil
    { last_search: @last_search, article: @article }
  end

  def should_create_search_prompt?
    return true unless get_last_search[:last_search].present?
    !get_last_search[:last_search].prompt.include?(search_param) || get_last_search[:last_search].prompt.length < search_param.to_s.length
  end

  def get_user
    @user_ip = user_ip
    @user = User.find_by_ip_address(@user_ip)

    @user ||= begin
      fake_name = Faker::Name.name
      User.create(name: fake_name, ip_address: @user_ip)
    end
  end

  def user_ip
    request.remote_ip
  end

  def search_param
    params[:query]&.strip
  end
end
