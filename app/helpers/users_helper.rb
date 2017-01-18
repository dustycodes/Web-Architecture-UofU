module UsersHelper
  def is_venue_owner?
    if Venue.find_by user_id: current_user.id
      return true
    end
    return false
  end
end
