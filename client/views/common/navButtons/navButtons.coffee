Template.navButtons.onRendered -> (
  this.$('#copyTemplateButton').hover(
    -> ($('#copyTemplateLabel').transition('fade left')),
    -> ($('#copyTemplateLabel').transition('fade left'))
  )

  this.$('#createTemplateButton').hover(
    -> ($('#createTemplateLabel').transition('fade left')),
    -> ($('#createTemplateLabel').transition('fade left'))
  )

  this.$('#manageTemplateButton').hover(
    -> ($('#manageTemplateLabel').transition('fade left')),
    -> ($('#manageTemplateLabel').transition('fade left'))
  )
)
