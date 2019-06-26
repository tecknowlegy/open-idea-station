require "rails_helper"

RSpec.describe EmailValidatable, type: :concern do
  include EmailValidatable

  describe "valid_email" do
    context "when email is valid" do
      it "returns a non nil object" do
        result = valid_email("dino.kennetcorp@gmail.com")

        expect(result).not_to eql nil
      end
    end

    context "when email is invalid" do
      it "returns nil" do
        result = valid_email("dino")

        expect(result).to eql nil
      end
    end
  end
end
