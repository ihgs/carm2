# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http:#coffeescript.org/
$ ->
  $('.repeater').repeater(
      # (Optional)
      # "defaultValues" sets the values of added items.  The keys of
      # defaultValues refer to the value of the input's name attribute.
      # If a default value is not specified for an input, then it will
      # have its value cleared.
      defaultValues: {

      },
      # (Optional)
      # "show" is called just after an item is added.  The item is hidden
      # at this point.  If a show callback is not given the item will
      # have $(this).show() called on it.
      show: ->
        $(this).slideDown()
      ,
      # (Optional)
      # "hide" is called when a user clicks on a data-repeater-delete
      # element.  The item is still visible.  "hide" is passed a function
      # as its first argument which will properly remove the item.
      # "hide" allows for a confirmation step, to send a delete request
      # to the server, etc.  If a hide callback is not given the item
      # will be deleted.
      hide: (deleteElement) ->
          if(confirm('Are you sure you want to delete this element?'))
            $(this).slideUp(deleteElement)
    )
