require "rails_helper"

RSpec.describe MedicalRecordsController do
  describe "post create" do
    it "will not allow more than 4 records per day" do
      user = User.first
      4.times { user.medical_records.create(level:rand(20...600))}  

      post :create, params: { 
        :medical_record => { 
          :user_id => user.id,
          :level => rand(20..600)
        }
      }
      expect(response).to redirect_to(user)
      expect(flash[:notice]).to eq "Daily limit exceed"
    end

  end
end