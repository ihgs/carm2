# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class TextbookStore
  textmap: {}
  get_text: (textbook_id) ->
    if this.textmap.hasOwnProperty(textbook_id)
      return this.textmap[textbook_id]
    else
      return null

  save_text: (textbook_id, data) ->
    this.textmap[textbook_id] = data

window.textbookstore = new TextbookStore

window.change_textbook = (my) ->
  textbook_id = $(my)[0].value
  select_unit = $(my).next()
  cache_data = window.textbookstore.get_text(textbook_id)
  if cache_data == null
    url = '/admin/textbooks/'+textbook_id+'.json'
    textbookXHR = $.ajax({
      async: true
      url: url
      dataType: 'json'
      })
    textbookXHR.done (data, stat, xhr) ->
      window.textbookstore.save_text(textbook_id, data)
      select_unit.children().remove()
      select_unit.append($('<option>').html("以下から選択").val(""))

      for key, unit of data.units
        select_unit.append($('<option>').html(unit.unit).val(unit.unit))
  else
    select_unit.children().remove()
    select_unit.append($('<option>').html("以下から選択").val(""))

    for key, unit of cache_data.units
      select_unit.append($('<option>').html(unit.unit).val(unit.unit))

window.change_unit = (my) ->
  select_unit = $(my)
  selected_index_unit = $(my)[0].selectedIndex
  select_textbook = select_unit.prev()
  select_subunit = select_unit.next()
  textbook_id = select_textbook[0].value
  data = window.textbookstore.get_text(textbook_id)

  select_subunit.children().remove()
  if selected_index_unit >= 1
    for subunit in data.units[selected_index_unit-1].subunits
      option = $('<option>').html(subunit).val(subunit)
      select_subunit.append(option)


$ ->
  $(".select_units").each ->
    select_unit = $(this)
    selected_data = $(this).attr("selected_data")
    select_textbook = select_unit.prev()
    select_subunit = select_unit.next()
    selected_subdata = select_subunit.attr("selected_data")

    textbook_id = select_textbook[0].value
    if textbook_id
      url = '/admin/textbooks/'+textbook_id+'.json'
      textbookXHR = $.ajax({
        async: true
        url: url
        dataType: 'json'
        })

      select_unit.append($('<option>').html("以下から選択").val(""))

      textbookXHR.done (data, stat, xhr) ->
        window.textbookstore.save_text(textbook_id, data)

        existed = false
        for key, unit of data.units
          option = $('<option>').html(unit.unit).val(unit.unit)
          if selected_data == unit.unit
            existed = true
            option.attr("selected", true)
            for subunit in unit.subunits
              sub_option = $('<option>').html(subunit).val(subunit)
              if subunit in selected_subdata.split(" ")
                sub_option.attr("selected", true)
              select_subunit.append(sub_option)

          select_unit.append(option)
        # ない場合は、選択肢に追加しておく
        if existed == false
          option = $('<option>').html(selected_data).val(selected_data)
          option.attr("selected", true)
          select_unit.append(option)
