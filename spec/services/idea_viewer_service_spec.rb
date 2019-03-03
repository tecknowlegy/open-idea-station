require "rails_helper"

RSpec.describe Acorn::IdeaViewerService do
  let!(:user) { create :user }
  let!(:idea) { create :idea }
  let!(:view_params) do
    {
      idea: idea,
      user: user,
      viewed_at: Time.now,
      viewer_ip: "127.0.0.1",
    }
  end

  describe ".call" do
    context "when an anonymous user views an idea" do
      it "records the view for the associated amount of times" do
        params = {
          idea: idea,
          user: nil,
          viewed_at: Time.now,
          viewer_ip: "127.0.0.1",
        }
        2.times do
          described_class.new(params).call
        end

        expect(idea.viewers.size).to be 2
      end

      it "records the idea impression for the associated amount of times" do
        params = {
          idea: idea,
          user: nil,
          viewed_at: Time.now,
          viewer_ip: "127.0.0.1",
        }

        5.times do
          described_class.new(params).call
        end

        expect(idea.impression).to be 5
      end
    end

    context "when a known user views an idea" do
      it "records the view once for umnlimited amount of times" do
        2.times do
          described_class.new(view_params).call
        end

        expect(idea.viewers.size).to be 1
      end

      it "records the idea impression for the associated amount of times" do
        params = {
          idea: idea,
          user: nil,
          viewed_at: Time.now,
          viewer_ip: "127.0.0.1",
        }

        5.times do
          described_class.new(params).call
        end

        expect(idea.impression).to be 5
      end
    end
  end
end
