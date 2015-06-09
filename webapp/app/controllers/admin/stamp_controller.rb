require 'stamp'
class Admin::StampController < ApplicationController
  layout 'admin/dashboard'

  def index
    t = Time.now
    stamp_list = Stamp::read(t.year, t.month)

    @stamp_daymap = {}
    stamp_list.each do |stamp|
      student = Student.find(stamp[:student_id])
      next unless student
      time  = Time.parse(stamp[:time])
      day = time.strftime("%Y%m%d")
      map_push(@stamp_daymap, day, student.id, student.fullname, time)
    end
  end

  def show
    t = Time.now
    @student = Student.find(params[:id])
    stamp_list = Stamp::read(t.year, t.month, @student.id.to_s)

    @stamp_daymap = {}
    stamp_list.each do |stamp|
      time  = Time.parse(stamp[:time])
      day = time.strftime("%Y%m%d")
      map_push(@stamp_daymap, day, time)
    end

  end

  private
    def map_push(map, *kv)
      if kv.length == 1
        raise Exception
      end
      k = kv.slice!(0).to_s
      if kv.length == 1
        v = kv[0]
        if map.has_key? k
          map[k].push(v)
        else
          map[k] = [v]
        end
      else
        map[k] = {} unless map.has_key? k
        map[k] = map_push(map[k], *kv)
      end
      return map
    end


end
