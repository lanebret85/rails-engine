require "rails_helper"

RSpec.describe ErrorMessage do
  describe "exists" do
    it "exists" do
      error_message = ErrorMessage.new("help", 418)

      expect(error_message).to be_an(ErrorMessage)
    end
  end

  describe "readable attributes" do
    it "has readable attributes" do
      error_message = ErrorMessage.new("help", 418)

      expect(error_message.message).to eq("help")
      expect(error_message.status).to eq(418)
    end
  end
end