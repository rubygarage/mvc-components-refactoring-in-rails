class ArticlesController < ApplicationController
  def index
    relation = Article.accessible_by(current_ability)
    @articles = PopularVideoQuery.new.call(relation)
  end
end