Transitions.transitionIn = 'slideLeftIn'
Transitions.transitionOut = 'slideLeftOut'

Router.configure(
  load: ->
    $('html, body').animate(
      scrollTop: 0
    , 400)
    $('#content').hide().fadeIn(800)
    @next()
)
