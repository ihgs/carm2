class Api::NoticeMailerController < ApplicationController
  before_action :authenticate_user!

  def get_smtp_config
    config = SmtpConfig.get()
    render json: config
  end

  def save_smtp_config
    config = SmtpConfig.first()
    if config
      if config.update(config_params)
        render json: config
      else
        redner json: config.errors, status: :unprocessable_entity
      end
    else
      config = SmtpConfig.new(config_params)
      if config.save
        render json: config
      else
        render json: config.errors, status: :unprocessable_entity
      end
    end
  end

  def send_test_mail
    if params[:to]
      NoticeMailer.sendmail_enterance_exit(params[:to], 'test mail', Time.now).deliver_now
      render nothing: true
    else
      render nothing: true, status: :error
    end
  end

  private
    def config_params
      params.require(:notice).permit(:subject, :body, smtp:[:address, :port, :user_name, :password])
    end
end
