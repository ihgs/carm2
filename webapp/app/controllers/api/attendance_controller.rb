require 'attendance'
class Api::AttendanceController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # time:int
  # card_id:string
  # device_name:string
  def index
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    time_sec = params["time"]
    card_id = params["card_id"]
    begin
      student = Student.find_by(card_id: card_id)
    rescue
    end
    if student != nil
      device_name = params["device_name"]
      time = Time.at(time_sec.to_i)
      Attendance::write(time, student.id, device_name, remote_ip)
      render :json => {status: "success", name: "#{student.name[:family_name]} #{student.name[:first_name]}" }
    else
      render :json => {status: "error", message: "This card is not registered." }
    end

  end
end
