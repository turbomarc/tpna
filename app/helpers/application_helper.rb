module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  #returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "TPNA Membership"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # Generate an icon tag for use with Bootstrap's set of Glyphicons.
  # See: http://getbootstrap.com/2.3.2/base-css.html#icons
  def icon(name)
    content_tag(:i, "", class: "icon-#{name}")
  end
end
