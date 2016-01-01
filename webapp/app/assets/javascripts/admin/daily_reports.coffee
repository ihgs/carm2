# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.change_textbook = (my) ->
  textbook_id = $(my)[0].selectedOptions[0].attributes['data_id'].value
  select_unit = $(my).next()
  url = '/admin/textbooks/'+textbook_id+'.json'
  textbookXHR = $.ajax({
    async: true
    url: url
    dataType: 'json'
    })
  textbookXHR.done (data, stat, xhr) ->
    select_unit.children().remove()
    for key, unit of data.units
      select_unit.append($('<option>').html(unit.unit).val(unit.unit))

$ ->
  $(".select_units").each ->
    select_unit = $(this)
    selected_data = $(this).attr("selected_data")
    select_textbook = select_unit.prev()
    data_id = select_textbook[0].selectedOptions[0].attributes['data_id']
    if data_id
      url = '/admin/textbooks/'+data_id.value+'.json'
      textbookXHR = $.ajax({
        async: true
        url: url
        dataType: 'json'
        })
      textbookXHR.done (data, stat, xhr) ->
        existed = false
        for key, unit of data.units
          option = $('<option>').html(unit.unit).val(unit.unit)
          if selected_data == unit.unit
            existed = true
            option.attr("selected", true)
          select_unit.append(option)
        # ない場合は、選択肢に追加しておく
        if existed == false
          option = $('<option>').html(selected_data).val(selected_data)
          option.attr("selected", true)
          select_unit.append(option)
