# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->


  $('#filter').keyup ->
    rex = new RegExp($(this).val(), 'i');
    $('.searchable tr').hide();
    visible = $('.searchable tr').filter ->
        return rex.test($("th", this).text());
    visible.show();
