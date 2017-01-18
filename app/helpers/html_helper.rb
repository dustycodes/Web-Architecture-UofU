module HtmlHelper

  def selfieMarkup object
    if object.selfie.empty? || object.selfie.nil?
      return image_tag("profilePlaceholder.jpg", :alt => "A sample profile picture.", :class => "selfie")
    else
      return image_tag(object.selfie, :alt => object.class.name, :class => "selfie")
    end
  end
end

