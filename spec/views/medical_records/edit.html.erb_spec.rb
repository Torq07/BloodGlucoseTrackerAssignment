require 'rails_helper'

RSpec.describe "medical_records/edit", type: :view do
  let(:medical_record) {
    MedicalRecord.create!(
      user: nil,
      level: 1
    )
  }

  before(:each) do
    assign(:medical_record, medical_record)
  end

  it "renders the edit medical_record form" do
    render

    assert_select "form[action=?][method=?]", medical_record_path(medical_record), "post" do

      assert_select "input[name=?]", "medical_record[user_id]"

      assert_select "input[name=?]", "medical_record[level]"
    end
  end
end
