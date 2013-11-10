module MembersHelper
  def link_to_google_maps(address)
    street_address = address.partition(',')[0]
    query = u("#{street_address}, Durham, NC")
    link_to address, "http://maps.google.com/?q=#{query}", target: "_blank"
  end
end
