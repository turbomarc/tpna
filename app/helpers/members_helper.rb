module MembersHelper
  def link_to_google_maps(street_address, citystzip )
    query = u("#{street_address}, #{citystzip}")
    link_to street_address, "http://maps.google.com/?q=#{query}", target: "_blank"
  end
end
