# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Util
  constructor: ->
  @div: (klass) ->
    d = $("<div>")
    d.addClass(klass)
    return d

class TimeTableRow

  constructor: (@start_hour, @end_hour, @hour_width, @hour_height) ->
    @wrap_div = Util.div("timetable_stamp_row")
    @wrap_div.css("position", "relative")
    @create_row()

  create_row: ->
    diff = @end_hour - @start_hour
    @wrap_div.css("height", @hour_height)
    for i in [@start_hour .. @end_hour]
      div = Util.div("timetable_row_hour")
      div.width(@hour_width).height(@hour_height)
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

    point_div = Util.div("timetable_event_point")
    point_div.attr("title",stamp.hour + ":" + stamp.min)
    point_div.tooltip()
    point_div.css("left", point-4).css("top",7)
    @point_divs.append(point_div)

  bar: ->
    bar_width = @max-@min
    bar = Util.div("timetable_event_bar")
    bar.width(bar_width).height(10).css("left", @min).css("top", 20)
    bar.attr("title", Math.floor(bar_width) + " min")
    bar.tooltip()

    wrap_bar = Util.div()
    wrap_bar.append(bar)


    wrap = Util.div()
    wrap.append(wrap_bar)
    wrap.append(@point_divs)
    return wrap


class Timetable

  width_student = 100
  width_date = 100

  constructor: (@start_hour, @end_hour, table_width, @hour_height) ->
    @hour_width = table_width/(@end_hour - @start_hour)

  set_data: (data)->
    @table_div = Util.div()
    for d in data
      row = Util.div("timetable_row")
      @table_div.append(row)

      date_div = Util.div("timetable_cell").width(width_date)
      date_div.text(d.date)
      row.append(date_div)
      date_data_div = Util.div("timetable_cell")
      row.append(date_data_div)
      for student_info in d.data
        student_row_div = Util.div("timetable_row_student")

        student_name_div = Util.div("timetable_cell").width(width_student)
        student_name_div.text(student_info.name)

        stamp_row = new TimeTableRow(@start_hour, @end_hour, @hour_width, @hour_height)
        stamp_row.set_stamps(student_info.stamps)

        stamp_row = stamp_row.row()
        stamp_row.addClass("timetable_cell")
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



  table = new Timetable(8, 21, 500, 40)
  table.set_data(sample)
  target.append(table.table_data())
