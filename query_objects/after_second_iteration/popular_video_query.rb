class PopularVideoQuery
  def call(relation)
    relation
      .where(type: :video)
      .where('view_count > ?', 100)
  end
end