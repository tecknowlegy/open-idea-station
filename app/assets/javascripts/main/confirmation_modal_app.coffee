class ConfirmationModal.App
  constructor: ->
    @confirmationModalUI = new ConfirmationModal.UI

  start: (customElements) =>
    @confirmationModalUI.showConfirmationModal(customElements)
    @confirmationModalUI.closeConfirmationModal()
