require 'rails_helper'

RSpec.describe MedicalRecord, type: :model do
  context "creating new record" do
      it "should have  level" do
        user = User.first
        medical_record = user.medical_records.new(level: nil)

        expect(medical_record).to_not be_valid
      end
  end
end
