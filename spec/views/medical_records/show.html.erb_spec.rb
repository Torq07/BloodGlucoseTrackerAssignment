require 'rails_helper'

RSpec.describe "medical_records/show", type: :view do
  before(:each) do
    assign(:medical_record, MedicalRecord.create!(
      user: nil,
      level: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
