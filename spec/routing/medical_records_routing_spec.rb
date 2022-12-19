require "rails_helper"

RSpec.describe MedicalRecordsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/medical_records").to route_to("medical_records#index")
    end

    it "routes to #new" do
      expect(get: "/medical_records/new").to route_to("medical_records#new")
    end

    it "routes to #show" do
      expect(get: "/medical_records/1").to route_to("medical_records#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/medical_records/1/edit").to route_to("medical_records#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/medical_records").to route_to("medical_records#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/medical_records/1").to route_to("medical_records#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/medical_records/1").to route_to("medical_records#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/medical_records/1").to route_to("medical_records#destroy", id: "1")
    end
  end
end
