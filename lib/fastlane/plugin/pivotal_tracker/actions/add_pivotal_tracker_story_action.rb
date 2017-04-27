module Fastlane
  module Actions
    module SharedValues
      PIVOTAL_TRACKER_STORY_ID = :PIVOTAL_TRACKER_STORY_ID
    end

    class AddPivotalTrackerStoryAction < Action
      def self.run(params)
        api_token = params[:api_token] || ENV["PIVOTAL_TRACKER_API_TOKEN"]
        project_id = params[:project_id] || ENV["PIVOTAL_TRACKER_PROJECT_ID"]

        response = Helper::PivotalTrackerHelper.get_current_iteration(api_token, project_id)
        before_id = nil
        response.first[:stories].each do |story|
          if story[:current_state] == 'started' || story[:current_state] == 'unstarted'
            before_id = story[:id]
            break
          end
        end if !response.empty? && response.first[:stories]

        data = {}
        data[:name] = params[:name]
        data[:description] = params[:description] if !params[:description].nil?
        data[:story_type] = params[:story_type] if !params[:story_type].nil?
        data[:current_state] = params[:current_state] if !params[:current_state].nil?
        data[:before_id] = before_id if !before_id.nil?

        response = Helper::PivotalTrackerHelper.create_story(api_token, project_id, data)
        if response[:kind] == 'story'
          UI.message("Created story [##{response[:id]}]: #{params[:name]}")
          Actions.lane_context[SharedValues::PIVOTAL_TRACKER_STORY_ID] = response[:id]
          return Actions.lane_context[SharedValues::PIVOTAL_TRACKER_STORY_ID]
        else
          raise Exception
        end
      end

      def self.description
        "Creates a story in a Pivotal Tracker project"
      end

      def self.authors
        ["Francis Li"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Creates a story in a Pivotal Tracker project"
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
                               description: "In-depth explanation of the story requirements",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :story_type,
                               description: "Type of story. Valid enumeration values: feature, bug, chore, release",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :current_state,
                               description: "Story's state of completion. Valid enumeration values: accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled",
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
