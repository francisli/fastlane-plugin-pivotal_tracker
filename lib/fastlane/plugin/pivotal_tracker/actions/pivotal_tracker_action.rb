module Fastlane
  module Actions
    class PivotalTrackerAction < Action
      def self.run(params)
        UI.message("The pivotal_tracker plugin is working!")
      end

      def self.description
        "Actions for creating release stories in a Pivotal Tracker project"
      end

      def self.authors
        ["Francis Li"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Actions for creating release stories in a Pivotal Tracker project from fastlane based on build or version number"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "PIVOTAL_TRACKER_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
