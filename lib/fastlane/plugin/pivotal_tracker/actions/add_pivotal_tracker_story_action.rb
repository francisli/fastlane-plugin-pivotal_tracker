module Fastlane
  module Actions
    class AddPivotalTrackerStoryAction < Action
      def self.run(params)
        api_token = params[:api_token] || ENV["PIVOTAL_TRACKER_API_TOKEN"]
        project_id = params[:project_id] || ENV["PIVOTAL_TRACKER_PROJECT_ID"]
        UI.message("The add_pivotal_tracker_story plugin is working! #{api_token} #{project_id} #{params.inspect}")
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
          FastlaneCore::ConfigItem.new(key: :api_token,
                                  env_name: "PIVOTAL_TRACKER_API_TOKEN",
                               description: "API token",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :project_id,
                                  env_name: "PIVOTAL_TRACKER_PROJECT_ID",
                               description: "The ID of the project",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :name,
                               description: "Name of the story",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :description,
                               description: "In-depth explanation of the story requirements.",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :type,
                               description: "Type of story. Valid enumeration values: feature, bug, chore, release",
                                  optional: true,
                                      type: String)
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
