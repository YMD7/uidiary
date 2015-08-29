$ ->
  # ===============================
  #
  #  + vimeo controller +
  #
  # ===============================
  

  #
  #  - Vimeo動画のコントロール -
  #

  $('.demo .row > div > iframe').each ->
    # プレイヤー要素などなど
    iframe = $(@)[0]
    player = $f(iframe)
    src    = $(@).attr('src')
    id     = src.match(/[0-9]+/)[0]
    
    # スクリーン要素を取得
    screenTop    = $(@).prevAll('.top')
    screenBottom = $(@).prevAll('.bottom')

    # When the player is ready, add listeners for pause, finish, and playProgress
    player.addEvent 'ready', ->
      player.addEvent 'pause', vimeoOnPause
      player.addEvent 'finish', vimeoOnFinish
      player.addEvent 'playProgress', vimeoOnPlayProgress

    # 再生・停止での表示切り替え
    vimeoOnPause = ->
      screenTop.removeClass('hidden')
      screenBottom.removeClass('hidden')
    vimeoOnFinish = ->
      screenTop.removeClass('hidden')
      screenBottom.removeClass('hidden')
    vimeoOnPlayProgress = (data, id) ->
      screenTop.addClass('hidden')
      screenBottom.addClass('hidden')
    
    # oEmbed
    endpoint = "https://vimeo.com/api/oembed.json?url="
    url = endpoint + "https%3A//vimeo.com/" + id
    $.getJSON url, (json) ->
      # タイトル
      title = json["title"]
      targetTitle = screenBottom.children('.cap').children('p')
      targetTitle.text title
    
      # 長さ
      duration = json["duration"]
      min = Math.floor(duration / 60)
      sec = duration % 60
      targetDuration = screenTop.children('.status').children('span').eq(0)
      targetDuration.text min + ":" + sec


  #
  #  - ローカルビデオのコントロール -
  #

  $('.interact .row > div video').each ->
    video = $(@)[0]

    interactionScreenTop    = $(@).prevAll('.top')
    interactionScreenCtl    = $(@).prevAll('.ctl')
    interactionScreenBottom = $(@).prevAll('.bottom')
    
    svgPlay  = interactionScreenCtl.children('.play')
    svgPause = interactionScreenCtl.children('.pause')
    
    interactionScreenCtl.click ->
      movState = interactionScreenCtl.attr('class').split(' ')[2]

      if movState is 'ready'
        video.play()
        $(@).removeClass('ready')
        $(@).addClass('pause')
        interactionScreenTop.addClass('hidden')
        interactionScreenBottom.addClass('hidden')
        svgPlay.attr 'class', (i, classNames) ->
          classNames + ' hidden'
        svgPause.attr 'class', (i, classNames) ->
          classNames.replace ' hidden', ''
      else if movState is 'pause'
        video.pause()
        $(@).removeClass('pause')
        $(@).addClass('ready')
        interactionScreenTop.removeClass('hidden')
        interactionScreenBottom.removeClass('hidden')
        svgPause.attr 'class', (i, classNames) ->
          classNames + ' hidden'
        svgPlay.attr 'class', (i, classNames) ->
          classNames.replace ' hidden', ''

    video.addEventListener 'ended', ->
      interactionScreenCtl.removeClass('pause')
      interactionScreenCtl.addClass('ready')
      interactionScreenTop.removeClass('hidden')
      interactionScreenBottom.removeClass('hidden')
      svgPause.attr 'class', (i, classNames) ->
        classNames + ' hidden'
      svgPlay.attr 'class', (i, classNames) ->
        classNames.replace ' hidden', ''



  # ===============================
  #
  #  + app edit controller +
  #
  # ===============================

  $('#content.apps-edit input.video-type').each ->
    btn = $(@)
    btn.bind 'click', ->
      
      # hidden クラスを除去（クラスを持っているかに関わらず）
      btn.parent('div').nextAll('.video').each ->
        videoDiv = $(@)
        videoDiv.addClass('hidden')

        # input に disabled属性を追加
        $(@).children('input').attr('disabled', 'disabled')

      # hidden クラスを付加
      targetElement = btn.parent('div').nextAll('.video.' + btn.val())
      targetElement.removeClass('hidden')

      # input の disabled属性を除去
      targetElement.children('input').removeAttr('disabled')



  # ==========================================================================
  #
  #  ++ hide flash message ++
  #
  # ==========================================================================
  $('#flash').mouseover ->
    $(@).fadeOut 'slow'



  # --------------------------------
  #                     + add app +
  # --------------------------------
  $('#search_form .search_button').click ->
    $('#result').addClass('hidden')

    search_type = $(@).attr("id")
    
    id   = $('#app_id').val()
    term = $('#term').val()

    switch search_type
      when "id_button" then url = "https://itunes.apple.com/lookup?id=" + id + "&country=jp"
      when "term_button" then url = "https://itunes.apple.com/search?term=" + term + "&media=software&country=jp&limit=10&offset=1"

    if id is "" and term is ""
      alert('値を入力してください')
    else
      $.ajax({url: url, async: true, dataType: 'jsonp',
      success: (res) ->
        console.log('success!')
        if search_type is "id_button"
          renderIdResult (res.results[0])
          $('.result.id').fadeIn(500)
          $('.result.id').removeClass('hidden')
        if search_type is "term_button"
          renderTermResult (res.results)
          $('.result.term').fadeIn(500)
          $('.result.term').removeClass('hidden')
      error: ->
        alert('error')
      })

    renderIdResult = (res) ->
      $('.result.term').children().remove()

      name     = res.trackName
      dev      = res.artistName
      genre    = res.genres[0]
      version  = res.version
      icon_url = res.artworkUrl512

      $('.result.id .icon img').attr('src', icon_url)
      $('.result.id .title h2').text(name)
      $('.result.id .title h3').text(dev)
      $('.result.id .title .cat').text(genre)

      $('#app_product_id').val(id)

    renderTermResult = (res) ->
      $('.result.id').addClass('hidden')
      $('.result.term').children().remove()

      for app, i in res
        name       = app.trackName
        dev        = app.artistName
        genre      = app.genres[0]
        product_id = app.trackId
        icon_url   = app.artworkUrl512
        $("
          <div class=\"header\">
            <div class=\"icon\">
              <img src=\"#{icon_url}\" alt=\"\">
            </div>
            <div class=\"title\">
              <div>
                <span class=\"cat\">#{app.genres[0]}</span>
              </div>
              <h2>#{app.trackName}</h2>
              <h3>#{app.artistName}</h3>
            </div>
            <div class=\"dl-btn\">
              <input type=\"submit\" class=\"insert-id\" value=\"Insert Id\" onclick=\"$('#app_id').val(#{product_id});\" />
            </div>
          </div>
          "
        ).appendTo('.result.term')

  $('.result.term input.insert-id').click ->
    alert hoge
      


  # ==========================================================================
  #
  #  ++ touch event ++
  #
  # ==========================================================================

  # --------------------------------
  #                     + index +
  # --------------------------------

  # -- + icon touch effect + -------------
  $('#main > div > div.card > a > div.mask > div.white').on 'click', ->
    $(@).animate({background: "rgba(255, 255, 255, 0.25)"}, 500)


  # --------------------------------
  #                     + show +
  # --------------------------------

























