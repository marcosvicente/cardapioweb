require 'rails_helper'



RSpec.describe "/restaurants", type: :request do
  describe "GET /index" do
    context "success" do
      let!(:owner) { create(:owner)}
      let!(:current_user) { create(:user, :with_owner, owner: )}

      let!(:restaurants) { create_list(:restaurant, 10)}

      it "should  be return all restaurants" do
        get "/restaurants/",
          headers: login_as(current_user)

        expect(response).to have_http_status(:success)

        expect(response_body).to be_an_instance_of(Array)

        restaurants.each_with_index do |restaurant, index|
          expect(response_body[index]["address"]).to eq(restaurant.address)
          expect(response_body[index]["lat"]).to eq(restaurant.lat)
          expect(response_body[index]["long"]).to eq(restaurant.long)
          expect(response_body[index]["opening_hours"]).to eq(restaurant.opening_hours)
          expect(response_body[index]["logo"]["url"]).to eq(restaurant.logo.url)
          expect(response_body[index]["owner"]["id"]).to eq(restaurant.owner.id)
        end
      end

      it "should be return all owners with paginate" do
        get "/restaurants/",
          headers: login_as(current_user),
          params: { page: 2, per_page: 5 }

        expect(response).to have_http_status(:success)

        expect(response_body.size).to eq(5)
      end
    end
  end

  describe "GET /show" do
    context "renders a successful response" do
      let!(:owner) { create(:owner) }
      let!(:current_user) { create(:user, :with_owner, owner: ) }
      let!(:restaurant) { create(:restaurant) }

      it "should  be return user with id" do
        get "/restaurants/#{restaurant.id}",
          headers: login_as(current_user)

        expect(response).to have_http_status(:success)

        expect(response_body["address"]).to eq(restaurant.address)
        expect(response_body["lat"]).to eq(restaurant.lat)
        expect(response_body["long"]).to eq(restaurant.long)
        expect(response_body["opening_hours"]).to eq(restaurant.opening_hours)
        expect(response_body["logo"]["url"]).to eq(restaurant.logo.url)
        expect(response_body["owner"]["id"]).to eq(restaurant.owner.id)
      end
    end
  end

  describe "POST /create" do
    let!(:owner) { create(:owner) }
    let!(:current_user) { create(:user, :with_owner, owner: ) }
    let!(:restaurant_attr) { attributes_for(:restaurant, owner_id: owner.id) }
    context "with valid parameters" do
      it "should be return create a restaurants" do
        post "/restaurants/",
          params: restaurant_attr,
          headers: login_as(current_user)

        expect(response).to have_http_status(:success)
        expect(response_body["address"]).to eq(restaurant_attr[:address])
        expect(response_body["lat"]).to eq(restaurant_attr[:lat])
        expect(response_body["long"]).to eq(restaurant_attr[:long])
        expect(response_body["opening_hours"]).to eq(restaurant_attr[:opening_hours])
        expect(response_body["owner_id"]).to eq(restaurant_attr[:owner_id])
        expect(response_body["logo"]["url"]).to_not be_empty

        saved_restaurant = Restaurant.last
        expect(saved_restaurant.address).to eq(restaurant_attr[:address])
        expect(saved_restaurant.lat).to eq(restaurant_attr[:lat])
        expect(saved_restaurant.long).to eq(restaurant_attr[:long])
        expect(saved_restaurant.opening_hours).to eq(restaurant_attr[:opening_hours])
        expect(saved_restaurant.logo.url).to_not be_empty
        expect(saved_restaurant.owner_id).to eq(restaurant_attr[:owner_id])
      end
    end

    context "with invalid parameters" do
      let!(:restaurant_invalid_attr) { attributes_for(:restaurant, email: "")}

      it "does not create a new Restaurant" do
        expect {
          post "/restaurants/",
               params: restaurant_invalid_attr, 
               headers: login_as(current_user)
        }.to change(Restaurant, :count).by(0)
      end

      it "renders a JSON response with errors for the new restaurant" do
        post "/restaurants/",
            params: restaurant_invalid_attr, 
            headers: login_as(current_user)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PUT /update" do
    let!(:owner) { create(:owner) }
    let!(:current_user) { create(:user, :with_owner, owner: ) }
    let!(:restaurant) { create(:restaurant) }
    let!(:restaurant_attr) { attributes_for(:restaurant, owner_id: owner.id) }

    context "with valid parameters" do
      it "updates the requested restaurant" do
        put "/restaurants/#{restaurant.id}",
          params: restaurant_attr,
          headers: login_as(current_user)

        expect(response_body["address"]).to eq(restaurant_attr[:address])
        expect(response_body["lat"]).to eq(restaurant_attr[:lat])
        expect(response_body["long"]).to eq(restaurant_attr[:long])
        expect(response_body["opening_hours"]).to eq(restaurant_attr[:opening_hours])
        expect(response_body["logo"]["url"]).to_not be_empty
        expect(response_body["owner_id"]).to eq(restaurant_attr[:owner_id])

        saved_restaurant = restaurant.reload
        expect(saved_restaurant.address).to eq(restaurant_attr[:address])
        expect(saved_restaurant.lat).to eq(restaurant_attr[:lat])
        expect(saved_restaurant.long).to eq(restaurant_attr[:long])
        expect(saved_restaurant.opening_hours).to eq(restaurant_attr[:opening_hours])
        expect(saved_restaurant.logo.url).to_not be_empty
        expect(saved_restaurant.owner_id).to eq(restaurant_attr[:owner_id])
      end
    end

    context "with invalid parameters" do
      let!(:restaurant_invalid_attr) { attributes_for(:restaurant, name: "")}

      it "renders a JSON response with errors for the restaurant" do
        put "/restaurants/#{restaurant.id}",
              params: restaurant_invalid_attr,
              headers: login_as(current_user)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:owner) { create(:owner) }
    let!(:current_user) { create(:user, :with_owner, owner: ) }
    let!(:restaurant) { create(:restaurant) }

    it "destroys the requested restaurant" do
      expect {
        delete "/restaurants/#{restaurant.id}", headers: login_as(current_user)
      }.to change(Restaurant, :count).by(-1)
    end
  end
end
