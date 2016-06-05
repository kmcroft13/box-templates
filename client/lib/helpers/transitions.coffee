Router.configure(
  load: ->
    $('html, body').animate(
      scrollTop: 0
    , 400)
    $('.pusher').hide().fadeIn(800)
    @next()
)
