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
  $('#search_button').click ->
    $('#result').addClass('hidden')

    id = $('#app_id').val()
    url = "https://itunes.apple.com/lookup?id=" + id + "&country=jp"

    if id is ""
      alert('idを入力してください')
    else
      $.ajax({url: url, async: true, dataType: 'jsonp',
      success: (res) ->
        console.log('success!')
        renderResult (res.results[0])
        $('#result').fadeIn(500)
        $('#result').removeClass('hidden')
      error: ->
        alert('error')
      })

    renderResult = (res) ->
      name     = res.trackName
      dev      = res.artistName
      genre    = res.genres[0]
      version  = res.version
      icon_url = res.artworkUrl512

      $('#icon img').attr('src', icon_url)
      $('#title h2').text(name)
      $('#title h3').text(dev)
      $('#title .cat').text(genre)

      $('#app_product_id').val(id)
      


  # ==========================================================================
  #
  #  ++ touch event ++
  #
  # ==========================================================================
  _touch = if ('ontouchstart' of document) then 'touchstart' else 'click'

  $('#main > div > div.card > a > div.mask > div.white').on _touch, ->
    $(@).animate({background: "rgba(255, 255, 255, 0.25)"}, 100)




























