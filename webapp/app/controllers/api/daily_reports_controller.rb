class Api::DailyReportsController < ApplicationController
  before_action :authenticate_user!

  class Trans


    class << self

      def get_id target
        if target.respond_to? :id
          return target.id
        end

        if target.is_a? Hash
          _id = target[:id]
          raise NoIdException.new unless _id

          if _id.is_a? String
            return _id
          elsif _id.is_a? Hash
            oid = _id[:$oid]
          end
          return oid if oid
        end
        raise NoIdException.new
      end

      def students _students
        return [] unless _students

        return _students.select {|s| s[:attendance] == true}.map do |student|
          {
            student_id: student[:id],
            attendance: student[:attendance],
            test_result: student[:test_result]
          }
        end
      end

      def contents _contents
        return [{}] unless _contents

        return _contents.map { | content |
          next unless content[:textbook]
          begin
            content[:textbook] = get_id(content[:textbook])
          rescue NoIdException
            puts content
            next
          end
          {
            students: content[:students],
            textbook: content[:textbook],
            unit: content[:unit][:unit],
            subunits: content[:subunits],
            page: content[:page],
            memo: content[:memo],
            }
          }.compact
      end

      def homeworks _homeworks
        return [{}] unless _homeworks

        return _homeworks.map { | homework |
          next unless homework[:textbook]
          begin
            homework[:textbook] = get_id(homework[:textbook])
          rescue NoIdException
            next
          end
          hw = {}
          hw[:students] = homework[:students];
          hw[:textbook] = homework[:textbook];
          hw[:unit] = homework[:unit][:unit];
          hw[:subunits] = homework[:subunits];
          hw[:page] = homework[:page];
          hw[:memo] = homework[:memo];
          hw[:due_date] =  homework[:due_date].to_time if homework[:due_date]
          hw
        }.compact
      end
    end
  end

  def index
    daily_reports = DailyReport.all
    render json: daily_reports.to_json
  end

  def show
    daily_report = DailyReport.find(params[:id])
    render json: daily_report.to_json
  end

  def create
    data = params.require(:daily_report)

    permit = [:date, :grade, :subject, :students, :contents, :homeworks, :note]

    opt = {}
    permit.each do |column|
      if Trans.respond_to?(column)
        opt[column] = Trans.send(column, data[column])
      else
        opt[column] = data[column]
      end
    end
    dp =  DailyReport.new(opt)
    if dp.save
      render json: {sucess: true, id: dp.id.to_s}
    else
      # TODO
      header :internal_server_error
    end
  end

  private




    def trim_data form_params
      form_params[:students].select! { |student|
        student[:attendance] == true
      }
      form_params[:contents].select! { |_, content|
        content[:students]
      }
      form_params[:homeworks].select! { |_, homework|
        homework[:students]
      }
      form_params
    end
end
