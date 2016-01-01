# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http:#coffeescript.org/
$ ->
  $(".edit_test_result").click ->
    target = $(this)
    if target.text() == 'edit'
      target.text('update')
      parent_tr = target.closest("tr")
      editable_tds = $('.editable', parent_tr)
      for editable_td in editable_tds
        editable_td_o = $(editable_td)
        result_name=editable_td_o.attr("name")
        result_id=editable_td_o.attr("id")
        editable_td_o.html('<input type="text" name='+ result_name + ' id='+result_id+' value="'+editable_td_o.text()+'">')
    else
      parent_tr = target.closest("tr")
      editable_tds = $('.editable', parent_tr)
      form = $('<form/>', {action: "/admin/school_test_results", method: 'post'})
      for editable_td in editable_tds
        form.append($(editable_td))

      test_id = $("#test_id")
      form.append($('<input/>', {type: 'hidden', name: 'school_test_result[school_test_id]', value: test_id.attr("value")}))

      student = $($('.student', parent_tr))
      form.append($('<input/>', {type: 'hidden', name: 'school_test_result[student_id]', value: student.attr("student_id")}))
      auth_token = $("#token")
      form.append($('<input/>', {type: 'hidden', name: 'authenticity_token', value: auth_token.attr("value")}))
      form.submit()
      # $.ajax
      #   async: false
      #   url: location.pathname
      #   type: "put"
      #   data: {tag: tag, level: level}
      #   dataType: "json"
      #   success: (data) ->
      #     console.log(data)
      #     target.text('edit')
      #     editable_td.html(level)
      #     show_message("update success", "alert alert-info")
      #   error: (data) ->
      #     console.log(data)
      #     show_message(data.responseText, "alert alert-danger")
