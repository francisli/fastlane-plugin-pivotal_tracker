describe Fastlane::Actions::PivotalTrackerAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The pivotal_tracker plugin is working!")

      Fastlane::Actions::PivotalTrackerAction.run(nil)
    end
  end
end
