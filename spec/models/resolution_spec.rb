require 'rails_helper'

describe Resolution, ".forgotten" do
  let(:user) { User.create(name: 'Bob') }
  let!(:resolution) { Resolution.create(title: 'Live Forever',
                                       description: 'So I can see the end of the universe',
                                       user_id: user.id) }

  context "resolutions that have no goals" do
    it "returns those resolutions that are older than 30 days" do
      resolution.update_attributes(updated_at: 31.days.ago)
      expect(Resolution.forgotten).to eq([resolution])
    end

    it "does not return resolutions younger than 30 days" do
      expect(Resolution.forgotten).to be_empty
    end
  end

  context "resolutions that have goals" do
    it "returns those resolutions that have no goals completed within 30 days" do
      oldie = Goal.create(name: "old", resolution_id: resolution.id)
      oldie.update(completed: true)
      oldie.update_attributes created_at: 31.days.ago, updated_at: 31.days.ago
      expect(Resolution.forgotten).to eq([resolution])
    end

    it "does not return resolutions that have any goals completed within 30 days" do
      oldie = Goal.create(name: "old", resolution_id: resolution.id)
      oldie.update_attributes created_at: 31.days.ago
      oldie.update(completed: true)
      expect(Resolution.forgotten).to be_empty
    end

    it "does not return resolutions that have any goals added within 30 days" do
      Goal.create(name: "goal", resolution_id: resolution.id)
      expect(Resolution.forgotten).to be_empty
    end
  end
end
