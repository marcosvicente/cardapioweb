require 'rails_helper'

RSpec.describe "/owners", type: :request do
  describe "GET /index" do
    context "success" do
      let!(:owners) { create_list(:owner, 10)}
      it "should  be return all owners" do
        get "/owners/"

        expect(response).to have_http_status(:success)

        expect(response_body).to be_an_instance_of(Array)

        owners.each_with_index do |owner, index|
          expect(response_body[index]["name"]).to eq(owner.name)
          expect(response_body[index]["email"]).to eq(owner.email)
          expect(response_body[index]["phone"]).to eq(owner.phone)
        end
      end

      it "should  be return all owners with paginate" do
        get "/owners/",
          params: { page: 2, per_page: 5 }

        expect(response).to have_http_status(:success)

        expect(response_body.size).to eq(5)
      end
    end
  end

  describe "GET /show" do
    let!(:owner) { create(:owner)}
    it "renders a successful response" do
      get "/owners/#{owner.id}"

      expect(response).to have_http_status(:success)
      expect(response_body["email"]).to eq(owner.email)
      expect(response_body["name"]).to eq(owner.name)
      expect(response_body["phone"]).to eq(owner.phone)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let!(:owner_attr) { attributes_for(:owner)}
      it "creates a new Owner" do

        post "/owners/",
          params: owner_attr


        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(owner_attr[:email])
        expect(response_body["name"]).to eq(owner_attr[:name])
        expect(response_body["phone"]).to eq(owner_attr[:phone])

        saved_owner = Owner.last
        expect(saved_owner.email).to eq(owner_attr[:email])
        expect(saved_owner.name).to eq(owner_attr[:name])
        expect(saved_owner.phone).to eq(owner_attr[:phone])
      end

      it "renders a JSON response with the new owner" do
        post "/owners/",
          params: owner_attr
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:owner_invalid_attr) { attributes_for(:owner, name: "")}

      it "does not create a new Owner" do
        expect {
          post "/owners/",
            params: owner_invalid_attr
        }.to change(Owner, :count).by(0)
      end

      it "renders a JSON response with errors for the new owner" do
        post "/owners/",
             params: owner_invalid_attr
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let!(:owner) { create(:owner)}
      let!(:owner_attr) { attributes_for(:owner)}

      it "updates the requested owner" do
        put "/owners/#{owner.id}",
          params: owner_attr 

        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(owner_attr[:email])
        expect(response_body["name"]).to eq(owner_attr[:name])
        expect(response_body["phone"]).to eq(owner_attr[:phone])

        owner.reload

        expect(owner.email).to eq(owner_attr[:email])
        expect(owner.name).to eq(owner_attr[:name])
        expect(owner.phone).to eq(owner_attr[:phone])
      end

      it "renders a JSON response with the owner" do
        put "/owners/#{owner.id}",
          params: owner_attr

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:owner) { create(:owner)}
      let!(:owner_invalid_attr) { attributes_for(:owner, name: nil)}

      it "renders a JSON response with errors for the owner" do
        put "/owners/#{owner.id}",
          params: owner_invalid_attr

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:owner) { create(:owner)}
    it "destroys the requested owner" do
      expect {
        delete "/owners/#{owner.id}"
      }.to change(Owner, :count).by(-1)
    end
  end
end
