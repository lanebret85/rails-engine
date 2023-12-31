require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to :merchant }
    it { should belong_to :customer }
    it { should have_many :transactions }
  end

  describe "validations" do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :status }
  end
end