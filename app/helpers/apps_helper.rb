# encoding: utf-8

module AppsHelper

  # Vimeo の iframe 要素をつくるヘルパー
  def vimeo_iframe(id, index)
    attrs = {
      :id => "player#{index}",
      :src => "https://player.vimeo.com/video/#{id}?api=1&player_id=player#{index}",
      :width => "242",
      :height => "428",
      :frameborder => "0",
      :webkitallowfullscreen => '',
      :mozallowfullscreen => '',
      :allowfullscreen => ''
    }
    content_tag(:iframe, '', attrs)
  end

end