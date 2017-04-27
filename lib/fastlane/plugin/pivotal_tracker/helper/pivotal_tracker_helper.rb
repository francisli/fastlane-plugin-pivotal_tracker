module Fastlane
  module Helper
    class PivotalTrackerHelper
      # class methods that you define here become available in your action
      # as `Helper::PivotalTrackerHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the pivotal_tracker plugin helper!")
      end
    end
  end
end
