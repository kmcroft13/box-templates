Template.basicLayout.onRendered -> (

  # initialize accordian
  $('#sidebar')
    .accordion()


  if (typeof $.fn.fullpage.destroy() != 'function')
    $.fn.fullpage.destroy('all')

)


Template.accountsLayout.onRendered -> (

  if (typeof $.fn.fullpage.destroy() != 'function')
    $.fn.fullpage.destroy('all')

)
