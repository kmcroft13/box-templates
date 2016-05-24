Tracker.autorun ->
  templateStatus = Session.get('templateStatus')

  if templateStatus == 'copy'
    $('#prep').addClass('hidden')
    $('#success').addClass('hidden')
    $('#fail').addClass('hidden')
    $('#warning').addClass('hidden')
    $('#copy').removeClass('hidden')
    $('html, body').animate(
      scrollTop: 0, 300)
  else if templateStatus == 'success'
    $('#copy').addClass('hidden')
    $('#prep').addClass('hidden')
    $('#fail').addClass('hidden')
    $('#warning').addClass('hidden')
    $('#success').removeClass('hidden')
    $('html, body').animate(
      scrollTop: 0, 300)
  else if templateStatus == 'fail'
    $('#warning').addClass('hidden')
    $('#copy').addClass('hidden')
    $('#prep').addClass('hidden')
    $('#success').addClass('hidden')
    $('#fail').removeClass('hidden')
    $('html, body').animate(
      scrollTop: 0, 300)
  else if templateStatus == 'warning'
    $('#copy').addClass('hidden')
    $('#prep').addClass('hidden')
    $('#success').addClass('hidden')
    $('#fail').addClass('hidden')
    $('#warning').removeClass('hidden')
    $('html, body').animate(
      scrollTop: 0, 300)
  else
    $('#copy').addClass('hidden')
    $('#success').addClass('hidden')
    $('#fail').addClass('hidden')
    $('#warning').addClass('hidden')
    $('#prep').removeClass('hidden')
