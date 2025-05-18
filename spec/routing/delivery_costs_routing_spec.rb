require "rails_helper"

RSpec.describe DeliveryCostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/delivery_costs").to route_to("delivery_costs#index")
    end

    it "routes to #new" do
      expect(get: "/delivery_costs/new").to route_to("delivery_costs#new")
    end

    it "routes to #show" do
      expect(get: "/delivery_costs/1").to route_to("delivery_costs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/delivery_costs/1/edit").to route_to("delivery_costs#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/delivery_costs").to route_to("delivery_costs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/delivery_costs/1").to route_to("delivery_costs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/delivery_costs/1").to route_to("delivery_costs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/delivery_costs/1").to route_to("delivery_costs#destroy", id: "1")
    end
  end
end
