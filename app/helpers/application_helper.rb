module ApplicationHelper
  # Amount should be a decimal between 0 and 1. Lower means darker
  def darken_color(hex_color, amount=0.4)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] = (rgb[0].to_i * amount).round
    rgb[1] = (rgb[1].to_i * amount).round
    rgb[2] = (rgb[2].to_i * amount).round
    "#%02x%02x%02x" % rgb
  end

  # Amount should be a decimal between 0 and 1. Higher means lighter
  def lighten_color(hex_color, amount=0.6)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
    rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
    rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
    "#%02x%02x%02x" % rgb
  end

  def border_color(color)
    darken_color(color,0.9)
  end

  def shadow_color(color)
    darken_color(color,0.6)
  end

  def nav_link_helper(nav_text, nav_path)
    content_tag(:li, nil, :class => ("active" if controller_name == nav_text.downcase)){
      link_to nav_text, nav_path
    }.html_safe
  end

  def link_to_delete(resource)
    unless @example_user
      link_to 'Destroy', resource, :method => :delete, data: { confirm: "Are you sure?" }, :class => "btn btn-danger btn-xs"
    end
  end

end
