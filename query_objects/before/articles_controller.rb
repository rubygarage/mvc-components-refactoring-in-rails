class ArticlesController < ApplicationController
  def index
    @articles = Article
                .accessible_by(current_ability)
                .where(type: :video)
                .where('view_count > ?', 100)
  end
end