require 'rails_helper'

RSpec.describe "medical_records/new", type: :view do
  before(:each) do
    assign(:medical_record, MedicalRecord.new(
      user: nil,
      level: 1
    ))
  end

  it "renders new medical_record form" do
    render

    assert_select "form[action=?][method=?]", medical_records_path, "post" do

      assert_select "input[name=?]", "medical_record[user_id]"

      assert_select "input[name=?]", "medical_record[level]"
    end
  end
end
