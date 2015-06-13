# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class TimeTableRow

  constructor: (@start_hour, @end_hour, @hour_width, @hour_height) ->
    @wrap_div =$("<div>")
    @wrap_div.css("position", "relative")
    @create_row()

  create_row: ->
    diff = @end_hour - @start_hour
    @wrap_div.css("height", @hour_height)
    for i in [@start_hour .. @end_hour]
      div = $("<div>")
      div.addClass("timetable_row_hour")
      div.height(@hour_height)
      div.width(@hour_width)
      div.css("left", (i-@start_hour)*@hour_width)
      div.text(i)
      @wrap_div.append(div)

  row: ->
    return @wrap_div

  set_stamps: (stamps)->
    bar = new Bar(@start_hour, @hour_width)
    for stamp in stamps
      bar.add(stamp)



    @wrap_div.append(bar.bar())


class Bar
  constructor:(@base, @hour_width) ->
    @min = (24+1)*@hour_width
    @max = -1
    @point_divs = $("<div>")

  add:(stamp) ->
    point = ((stamp.hour - @base) + stamp.min/60.0)*@hour_width
    if point < @min
      @min = point
    if point > @max
      @max = point

    point_div = $("<div>")
    point_div.addClass("timetable_event_point")
    point_div.css("left", point-6)
    @point_divs.append(point_div)

  bar: ->
    bar = $("<div>")
    bar.addClass("timetable_event_bar")
    bar.css("left", @min)
    bar.css("top", 15)
    bar.width(@max-@min)
    wrap_bar = $("<div>")
    wrap_bar.append(bar)

    wrap = $("<div>")
    wrap.append(wrap_bar)
    wrap.append(@point_divs)
    return wrap


class Timetable
  constructor: (@start_hour, @end_hour, @hour_width, @hour_height) ->

  set_data: (data)->
    @table_div = $("<div>")
    for d in data
      row = $("<div>")
      @table_div.append(row)

      date_div = $("<div>")
      date_div.width(100)
      date_div.text(d.date)
      date_div.css("display", "table-cell")
      row.append(date_div)
      date_data_div = $("<div>")
      date_data_div.css("display", "table-cell")
      row.append(date_data_div)
      for student_info in d.data
        student_row_div = $("<div>")

        student_name_div = $("<div>")
        student_name_div.text(student_info.name)
        student_name_div.width(100)
        student_name_div.css("display", "table-cell")

        stamp_row = new TimeTableRow(@start_hour, @end_hour, @hour_width, @hour_height)
        stamp_row.set_stamps(student_info.stamps)

        stamp_row = stamp_row.row()
        stamp_row.css("display", "table-cell")
        student_row_div.append(student_name_div)
        student_row_div.append(stamp_row)

        date_data_div.append(student_row_div)

  table_data: ->
    return @table_div


$ ->
  sample = [
    {
      date: "20150610",
      data:[
        {
          name: "山田　太郎",
          stamps: [
            { hour: 9, min: 0 },
            { hour: 10, min: 30 },
            { hour: 13, min: 40 }
            ]
        },
        {
          name: "鈴木　一郎",
          stamps: [
            { hour: 10, min: 0 },
            { hour: 10, min: 10 },
            { hour: 13, min: 40 }
            ]
        }
      ]
    },
    {
      date: "20150611",
      data: [
        {
          name: "山田　太郎",
          stamps: [
            { hour: 15, min: 0 }
            ]
        },
        {
          name: "鈴木　一郎",
          stamps: [
            { hour: 12, min: 0 },
            { hour: 14, min: 10 },
            { hour: 14, min: 40 }
            ]
        }
      ]
    },

  ]
  target = $("#timestamp_table")



  table = new Timetable(8, 21, 30, 40)
  table.set_data(sample)
  target.append(table.table_data())
