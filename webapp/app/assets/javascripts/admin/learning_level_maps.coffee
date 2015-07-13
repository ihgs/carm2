# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".edit_level").click ->
    target = $(this)
    if target.text() == 'edit'
      target.text('update')
      parent_tr = target.closest("tr")
      editable_td = $('.editable', parent_tr)
      editable_td.html('<input type="text" value="'+editable_td.text()+'">')
    else
      parent_tr = target.closest("tr")
      tag_th = $('th', parent_tr)
      tag = tag_th.text()
      editable_td = $('.editable', parent_tr)
      level = editable_td.children('input').val()
      $.ajax
        async: false
        url: location.pathname
        type: "put"
        data: {tag: tag, level: level}
        dataType: "json"
      #TODO SUCCESS ERROR
      target.text('edit')
      editable_td.html(level)



  $('#filter').keyup ->
    rex = new RegExp($(this).val(), 'i');
    $('.searchable tr').hide();
    visible = $('.searchable tr').filter ->
        return rex.test($(".search", this).text());
    visible.show();
