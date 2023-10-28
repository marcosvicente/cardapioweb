require 'rails_helper'

RSpec.describe "Administrations", type: :request do
  describe "GET /restaurants_owner" do
    let!(:owner) { create(:owner)}
    let!(:restaurants) { create_list(:restaurant, 10, owner: owner)}

    it "returns http success" do
      get "/administrations/#{owner.id}/restaurants_owner"

      expect(response).to have_http_status(:ok)

      expect(response_body["owner"]["email"]).to eq(owner.email)
      expect(response_body["owner"]["name"]).to  eq(owner.name)
      expect(response_body["owner"]["phone"]).to eq(owner.phone)

      restaurants.each_with_index do |restaurant, index|
        expect(response_body["restaurant"][index]["address"]).to        eq(restaurant.address)
        expect(response_body["restaurant"][index]["lat"]).to            eq(restaurant.lat)
        expect(response_body["restaurant"][index]["long"]).to           eq(restaurant.long)
        expect(response_body["restaurant"][index]["opening_hours"]).to  eq(restaurant.opening_hours)
        expect(response_body["restaurant"][index]["logo"]["url"]).to    eq(restaurant.logo.url)
      end
    end
  end

  describe "PUT /change_restaurant_to_owner" do
    let!(:owner) { create(:owner)}
    let!(:new_owner) { create(:owner)}

    let!(:restaurant) { create(:restaurant, owner: owner)}
    context "success" do
      it "returns http success" do
        put "/administrations/change_restaurant_to_owner",
          params: { owner_id: new_owner.id, restaurant_id: restaurant.id }

        expect(response).to have_http_status(:success)
        new_owner.reload
        expect(new_owner.restaurant.first.id).to eq(restaurant.id)
        expect(owner.restaurant).to be_blank
      end
    end
    
    context "fail" do
      it "returns http unprocessable_entity to restaurant_id nil" do
        put "/administrations/change_restaurant_to_owner",
          params: { owner_id: new_owner.id, restaurant_id: nil }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body["error"]).to include("Parâmetros obrigatórios não estão presentes!")
      end

      it "returns http unprocessable_entity to owner_id nil" do
        put "/administrations/change_restaurant_to_owner",
          params: { owner_id: nil, restaurant_id: restaurant.id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body["error"]).to include("Parâmetros obrigatórios não estão presentes!")
      end
    end
  end

  describe "GET /get_opened_restaurant" do
    let!(:owner) { create(:owner)}
    let!(:restaurant) { create(:restaurant, owner: owner) }
    context "success" do
      context "in week" do
        it "returns http success with json Aberto" do
          get "/administrations/get_opened_restaurant",
            params: { restaurant_id: restaurant.id, times_open: "10H", day_of_week: "segunda"}

          expect(response).to have_http_status(:success)
          expect(response.body).to eq("Aberto")
        end

        it "returns http success  with json Fechado" do
          get "/administrations/get_opened_restaurant",
            params: { restaurant_id: restaurant.id, times_open: "23h", day_of_week: "segunda"}

          expect(response).to have_http_status(:success)
          expect(response.body).to eq("Fechado")
        end
      end

      context "in endweek" do
        it "returns http success  with json Aberto" do
          get "/administrations/get_opened_restaurant",
            params: { restaurant_id: restaurant.id, times_open: "13h", day_of_week: "domingo"}

          expect(response).to have_http_status(:success)
          expect(response.body).to eq("Aberto")
        end

        it "returns http success  with json Fechado" do
          get "/administrations/get_opened_restaurant",
            params: { restaurant_id: restaurant.id, times_open: "23h", day_of_week: "sábado"}

          expect(response).to have_http_status(:success)
          expect(response.body).to eq("Fechado")
        end
      end
    end

    context "fail" do
      it "returns http unprocessable_entity with day_of_week not valid" do
        get "/administrations/get_opened_restaurant",
          params: { restaurant_id: restaurant.id, times_open: "20H", day_of_week: ""}
        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to include("Day of week parametro não e valido")
      end
    end
  end
end
