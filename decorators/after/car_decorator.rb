class CarDecorator < Draper::Decorator
  delegate_all
  def meta_title
    result =
      if object.title_for_head
        "#{ object.title_for_head } | #{I18n.t('beautiful_cars')}"
      else
        t('beautiful_cars')
      end
    h.content_tag :title, result
  end

  def meta_description
    if object.description_for_head
      h.content_tag :meta, nil ,content: object.description_for_head
    end
  end

  def image
    result = object.image.url.present? ? object.image.url : 'no-images.png'
    h.image_tag result
  end

  def brand
    get_info object.brand
  end

  def model
    get_info object.model
  end

  def notes
    get_info object.notes
  end

  def owner
    get_info object.owner
  end

  def city
    get_info object.city
  end

  def owner_phone
    get_info object.phone
  end

  def state
    object.used ? I18n.t('used') : I18n.t('new')
  end

  def created_at
    object.created_at.strftime("%B %e, %Y")
  end

  private
  def get_info value
    value.present? ? value : t('undefined')
  end
end