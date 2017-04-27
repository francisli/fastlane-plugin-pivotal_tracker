module Fastlane
  module Helper
    URL_BASE = "https://www.pivotaltracker.com/services/v5/projects"

    class PivotalTrackerHelper
      # class methods that you define here become available in your action
      # as `Helper::PivotalTrackerHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the pivotal_tracker plugin helper!")
      end

      def self.get_current_iteration(api_token, project_id)
        uri = URI.parse("#{URL_BASE}/#{project_id}/iterations?scope=current")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        response = http.get(uri, {
          'X-TrackerToken': api_token
        })
        return JSON.parse(response.body, symbolize_names: true)
      end

      def self.create_story(api_token, project_id, data)
        uri = URI.parse("#{URL_BASE}/#{project_id}/stories")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        response = http.post(uri, data.to_json, {
          'Content-Type': 'application/json',
          'X-TrackerToken': api_token
        })
        return JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
