require 'rails_helper'

RSpec.describe "medical_records/index", type: :view do
  before(:each) do
    assign(:medical_records, [
      MedicalRecord.create!(
        user: nil,
        level: 2
      ),
      MedicalRecord.create!(
        user: nil,
        level: 2
      )
    ])
  end

  it "renders a list of medical_records" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
