class Venue < ActiveRecord::Base
  belongs_to :user

  def selfieMarkup
    @selfieMarkupString = "<img class='selfie' src='#{self.selfie}' alt='Venue Selfie'>".html_safe
    return @selfieMarkupString
  end
end
