require 'stamp'
class Api::StampController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # time:int
  # card_id:string
  # device_name:string
  def index
    reader_token = request.env["HTTP_ACCESS_TOKEN"]
    if Token.where(token: reader_token).count == 0
      render :json=>{status: "error", message: "This reader is not registered"}
      return
    end

    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    time_sec = params["time"]
    card_id = params["card_id"]
    begin
      student = Student.find_by(card_id: card_id)
    rescue
      begin
        student = Student.find_by(card_id: card_id.upcase)
      rescue
      end
    end
    if student == nil
      render :json => {status: "error", message: "This card(#{card_id}) is not registered." }
      return
    end
    device_name = params["device_name"]
    time = Time.at(time_sec.to_i)
    send_mail = send_mail? time, student
    Stamp::write(time, student.id, device_name, remote_ip)
    # begin
    if student.mail and send_mail
      begin
        NoticeMailer.sendmail_enterance_exit(student.mail, student.fullname, time).deliver_now
        render :json => {status: "success", name: "#{student.name[:family_name]} #{student.name[:first_name]}" }
        return
      rescue => e
        logger.info(e.message)
        render :json => {status: "error", name: "#{student.name[:family_name]} #{student.name[:first_name]}", mail: "NOT_SEND"  }
        return
      end
    end
    render :json => {status: "success", name: "#{student.name[:family_name]} #{student.name[:first_name]}", mail: "NOT_SEND" }
  end

  # 1分以内ならメールを送信しない
  def send_mail? time, student
    stamp_list = Stamp::read(time.year, time.month, student.id.to_s)
    if stamp_list.length == 0
      return true
    end

    last = stamp_list.last
    last_time  = Time.parse(last[:time])
    return time - last_time > 60
  end
end
