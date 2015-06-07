module Attendance

  class << self


    def write time, student_id, device_name, device_ip
      store_dir = Webapp::Application::config.attendance_store_dir
      dir = File.join(store_dir, time.year.to_s, time.month.to_s)
      FileUtils.mkdir_p(dir) unless File.exists?(dir)
      log_file = File.join(dir , "attendance.log")

      File.open(log_file, "a") do |f|
        f.puts "#{time},  #{student_id}, #{device_name}, #{device_ip}"
      end
    end

    def read year, month, student_id=nil
      store_dir = Webapp::Application::config.attendance_store_dir
      dir = File.join(store_dir, year.to_s, month.to_s)
      log_file = File.join(dir , "attendance.log")

      return [] unless File.exists?(log_file)

      history = []
      File.open(log_file, "r") do |f|
        while l = f.gets
          l.strip!
          time, s_id, device_name, device_ip = l.split(/\s*,\s*/)
          if student_id == nil || student_id == s_id
            history.push({
              time: time,
              student_id: s_id,
              device_name: device_name,
              device_ip: device_ip
              })
          end
        end
      end
      return history
    end

  end
end
