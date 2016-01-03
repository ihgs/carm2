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


class Textbook
  select_textbook: null
  select_unit: null
  select_subunit: null

  constructor: (type, jq_select) ->
    if type == "textbook"
      this.select_textbook = jq_select
      this.select_unit = jq_select.next()
      this.select_subunit = this.select_unit.next()
    else if type == "unit"
      this.select_textbook = jq_select.prev()
      this.select_unit = jq_select
      this.select_subunit = jq_select.next()
    else
      console.log("[error]unknown type:"+type)

  textbook_ajax: ->
    url = '/admin/textbooks/'+this.get_textbook_id()+'.json'
    textbookXHR = $.ajax({
      async: true
      url: url
      dataType: 'json'
      })
    return textbookXHR

  option: (html, value) ->
    if value == undefined
      value = html
    return $('<option>').html(html).val(value)

  get_textbook_id: ->
    return this.select_textbook[0].value

  set_select_unit: (units) ->
    this.select_unit.children().remove()
    this.select_unit.append(this.option("以下から選択",""))
    for key, unit of units
      this.select_unit.append(this.option(unit.unit))

  set_select_unit2: (units) ->
    existed = false
    for key, unit of units
      option = this.option(unit.unit)
      if this.selected_unit_value() == unit.unit
        existed = true
        option.attr("selected", true)
        this.set_select_subunits(unit.subunits)

      this.select_unit.append(option)
    return existed

  set_select_subunits: (subunits) ->
    for subunit in subunits
      sub_option = this.option(subunit)
      if subunit in this.selected_subunit_list()
        sub_option.attr("selected", true)
      this.select_subunit.append(sub_option)

  selected_unit_value: ->
    return this.select_unit.attr("selected_data")

  selected_subunit_list: ->
    str = this.select_subunit.attr("selected_data")
    if str == undefined
      return []
    return str.split(" ")

  load_textbook_data: (cb) ->
    textbook_id = this.get_textbook_id()
    cache_data = window.textbookstore.get_text(textbook_id)
    if cache_data == null
      textbookXHR = this.textbook_ajax()
      textbookXHR.done (data, stat, xhr) ->
        window.textbookstore.save_text(textbook_id, data)
        return cb data
    else
      return cb cache_data

window.change_textbook = (my) ->
  tb = new Textbook("textbook", $(my))
  tb.load_textbook_data (data) ->
    tb.set_select_unit(data.units)

window.change_unit = (my) ->
  tb = new Textbook("unit", $(my))
  selected_index_unit = $(my)[0].selectedIndex

  tb.load_textbook_data (data) ->
    tb.select_subunit.children().remove()
    if selected_index_unit >= 1
      for subunit in data.units[selected_index_unit-1].subunits
        option = tb.option(subunit)
        tb.select_subunit.append(option)

$ ->
  $(".select_units").each ->
    tb = new Textbook("unit", $(this))

    textbook_id = tb.get_textbook_id()
    if textbook_id
      tb.select_unit.append(tb.option("以下から選択", ""))
      tb.load_textbook_data (data) ->
        existed = tb.set_select_unit2(data.units)
        # ない場合は、選択肢に追加しておく
        if existed == false
          option = tb.option(tb.selected_unit_value())
          option.attr("selected", true)
          tb.select_unit.append(option)
