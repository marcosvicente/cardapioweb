require 'rails_helper'

RSpec.describe "Users", type: :request do
  # GET /users
  describe "GET /index" do
    context "success" do
      let!(:users) { create_list(:user, 10)}
      it "should be return all users" do
        get "/users/"

        expect(response).to have_http_status(:success)

        expect(response_body).to be_an_instance_of(Array)

        users.each_with_index do |user, index|
          expect(response_body[index]["email"]).to eq(user.email)
          expect(response_body[index]["username"]).to eq(user.username)
          expect(response_body[index]["first_name"]).to eq(user.first_name)
          expect(response_body[index]["last_name"]).to eq(user.last_name)
        end
      end

      it "should  be return all users with paginate" do
        get "/users/",
          params: { page: 2, per_page: 5 }

        expect(response).to have_http_status(:success)

        expect(response_body.size).to eq(5)
      end
    end
  end

  # GET /users/:id
  describe "GET /show" do
    context "success" do

      let!(:user) { create(:user)}
      it "should  be return user with id" do
        get "/users/#{user.id}"

        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(user.email)
        expect(response_body["username"]).to eq(user.username)
        expect(response_body["first_name"]).to eq(user.first_name)
        expect(response_body["last_name"]).to eq(user.last_name)
      end
    end
  end

  describe "POST /create" do
    context "success" do
      let!(:user_attr) do 
         attributes_for(:user, :with_owner)
        #  user_attr[:owner_id] = user_attr[:owner].id
      end

      it "should be create a users" do
        post "/users/",
          params: user_attr

        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(user_attr[:email])
        expect(response_body["username"]).to eq(user_attr[:username])
        expect(response_body["first_name"]).to eq(user_attr[:first_name])
        expect(response_body["last_name"]).to eq(user_attr[:last_name])
        expect(response_body["owner_id"]).to eq(user_attr[:owner_id])

        saved_user = User.last
        expect(saved_user.email).to eq(user_attr[:email])
        expect(saved_user.username).to eq(user_attr[:username])
        expect(saved_user.first_name).to eq(user_attr[:first_name])
        expect(saved_user.last_name).to eq(user_attr[:last_name])
        expect(saved_user.owner_id).to eq(user_attr[:owner_id])
      end
    end

    context "with invalid parameters" do
      let!(:user) { create(:user)}
      let!(:user_invalid_attr) { attributes_for(:user, email: user.email)}
      it "does not create a new User" do
        expect {
          post "/users/",
            params: user_invalid_attr

        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        post "/users/",
          params: user_invalid_attr

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PUT /update" do
    context "success" do
      let!(:user) { create(:user)}

      let!(:user_attr) { attributes_for(:user, :with_owner)}
      it "should be return update user" do
        put "/users/#{user.id}",
          params: user_attr
        
        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(user_attr[:email])
        expect(response_body["username"]).to eq(user_attr[:username])
        expect(response_body["first_name"]).to eq(user_attr[:first_name])
        expect(response_body["last_name"]).to eq(user_attr[:last_name])
        expect(response_body["owner_id"]).to eq(user_attr[:owner_id])
        
        updated_user = user.reload
        expect(updated_user.email).to eq(user_attr[:email])
        expect(updated_user.username).to eq(user_attr[:username])
        expect(updated_user.first_name).to eq(user_attr[:first_name])
        expect(updated_user.last_name).to eq(user_attr[:last_name])
        expect(updated_user.owner_id).to eq(user_attr[:owner_id])
      end
    end

    context "with invalid parameters" do
      let!(:user) { create(:user)}

      let!(:user_invalid_attr) { attributes_for(:user, name: "")}
      it "renders a JSON response with errors for the user" do

        put "/users/#{user.id}",
          params: { user: user_invalid_attr }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:user) { create(:user)}
    it "should  be destroy user" do
      expect {
        delete "/users/#{user.id}", as: :json
      }.to change(User, :count).by(-1)
    end
  end
end
