Template.basicLayout.onRendered -> (

  $(".dropdown-button").dropdown()


  if (typeof $.fn.fullpage.destroy() != 'function')
    $.fn.fullpage.destroy('all')

)


Template.accountsLayout.onRendered -> (

  if (typeof $.fn.fullpage.destroy() != 'function')
    $.fn.fullpage.destroy('all')

)
