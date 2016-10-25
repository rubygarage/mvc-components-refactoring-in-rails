class ArticlePresenter < BasePresenter
  presents :article
  delegate :title, :text, to: :article

  def meta_title
    title = article.title_for_head_tag || I18n.t('default_title_for_head')
    h.content_tag :title, title
  end

  def meta_description
    description = article.description_for_head_tag || I18n.t('default_description_for_head')
    h.content_tag :meta, nil, content: description
  end

  def og_type
    open_graph_meta "article", "og:type"  
  end
  
  def og_title
    open_graph_meta "og:title", article.title
  end

  def og_description
    open_graph_meta "og:description", article.description_for_head_tag if article.description_for_head_tag
  end
  
  def og_image
    if article.image
      image = "#{request.protocol}#{request.host_with_port}#{article.main_image}"
      open_graph_meta "og:image", image
    end
  end

  def author_name
    if article.author 
      h.content_tag :p, "#{article.author.first_name} #{article.author.last_name}"
    end
  end 

  def image
   if article.image
     h.image_tag article.image.url  
   else
      h.image_tag 'no-image.png'
   end
  end
  
  private 
  
  def open_graph_meta content, property 
    h.content_tag :meta, nil, content: content, property: property
  end  
end