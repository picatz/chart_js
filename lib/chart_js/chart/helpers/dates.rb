require 'date'

module ChartJS

  module Helpers

    module Dates
      WORK_DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
      MONDAY_TO_SUNDAY = WORK_DAYS + ['Saturday', 'Sunday']

      def days_of_the_week(abrv: false)
        days = if abrv
                 Date::DAYNAMES
               else
                 Date::ABBR_DAYNAMES
               end
        return days unless block_given?
        days.each do |day|
          yield day
        end
      end

      def work_days
        return WORK_DAYS unless block_given?
        WORK_DAYS.each do |day|
          yield day
        end 
      end

      alias monday_to_friday work_days

      def monday_to_sunday
        return MONDAY_TO_SUNDAY unless block_given?
        MONDAY_TO_SUNDAY.each do |day|
          yield day
        end
      end

      def months_of_the_year(abrv: false)
        months = if abrv
                   Date::MONTHNAMES.reject(&:nil?)
                 else
                   Date::ABBR_MONTHNAMES.reject(&:nil?)
                 end
        return months unless block_given?
        months.each do |month|
          yield month
        end
      end
    end

  end

end
