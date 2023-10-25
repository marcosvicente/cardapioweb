require 'rails_helper'

RSpec.describe "Users", type: :request do
  # GET /users
  describe "GET /index" do
    context "success" do
      let!(:users) { create_list(:user, 10)}
      it "should  be return all users" do
        get "/users/",
          headers: login_as(users[0])

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
          headers: login_as(users[0]),
          params: { page: 2, per_page: 5 }

        expect(response).to have_http_status(:success)

        expect(response_body.size).to eq(5)
      end
    end
  end

  # GET /users/:id
  describe "GET /show" do
    context "success" do
      let!(:current_user) { create(:user)}

      let!(:user) { create(:user)}
      it "should  be return user with id" do
        get "/users/#{user.id}",
          headers: login_as(current_user)

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
      let!(:current_user) { create(:user)}

      let!(:user_attr) { attributes_for(:user)}
      it "should  be retorn all users" do
        post "/users/",
          headers: login_as(current_user),
          params: user_attr

        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(user_attr[:email])
        expect(response_body["username"]).to eq(user_attr[:username])
        expect(response_body["first_name"]).to eq(user_attr[:first_name])
        expect(response_body["last_name"]).to eq(user_attr[:last_name])
      end
    end

    context "failure" do
    end
  end

  describe "PUT /update" do
    context "success" do
      let!(:current_user) { create(:user)}

      let!(:user_attr) { attributes_for(:user)}
      it "should  be retorn all users" do
        post "/users/",
          headers: login_as(current_user),
          params: user_attr

        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(user_attr[:email])
        expect(response_body["username"]).to eq(user_attr[:username])
        expect(response_body["first_name"]).to eq(user_attr[:first_name])
        expect(response_body["last_name"]).to eq(user_attr[:last_name])
      end
    end

    context "failure" do
    end
  end

  describe "DELETE /destroy" do
    context "success" do
      let!(:current_user) { create(:user)}

      let!(:user_attr) { attributes_for(:user)}
      it "should  be retorn all users" do
        post "/users/",
          headers: login_as(current_user),
          params: user_attr

        expect(response).to have_http_status(:success)
        expect(response_body["email"]).to eq(user_attr[:email])
        expect(response_body["username"]).to eq(user_attr[:username])
        expect(response_body["first_name"]).to eq(user_attr[:first_name])
        expect(response_body["last_name"]).to eq(user_attr[:last_name])
      end
    end

    context "failure" do
    end
  end
end
