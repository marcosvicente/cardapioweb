require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  let!(:user) { create(:user) }

  describe "GET /login" do
    context "should be access with email" do
      context "success" do
        it "returns http success" do
          get "/authentications/login",
            params: { email: user.email, password: '123456' }    

          expect(response).to have_http_status(:success)

          expect(response_body["token"]).to_not be_nil
          expect(response_body["email"]).to eq(user.email)
          expect(response_body["username"]).to eq(user.username)
          expect(response_body["exp"]).to_not be_nil
        end
      end

      context "failure" do
        it "returns http unauthorized with email nil" do
          get "/authentications/login",
            params: { email: nil, password: '123456' }    
          
          expect(response).to have_http_status(:unauthorized)
          expect(response_body["error"]).to eq("unauthorized")
        end

        it "returns http unauthorized with password nil" do
          get "/authentications/login",
            params: { email: user.email, password: nil }    
          
          expect(response).to have_http_status(:unauthorized)
          expect(response_body["error"]).to eq("unauthorized")
        end

        it "returns http unauthorized with password wrong" do
          get "/authentications/login",
            params: { email: user.email, password: '9999999' }    
          
          expect(response).to have_http_status(:unauthorized)
          expect(response_body["error"]).to eq("unauthorized")
        end
      end
    end

    context "should be access with username" do
      context "success" do
        it "returns http success with username" do
          get "/authentications/login",
            params: { username: user.username, password: '123456' }    
          
          expect(response).to have_http_status(:success)
          expect(response_body["token"]).to_not be_nil
          expect(response_body["email"]).to eq(user.email)
          expect(response_body["username"]).to eq(user.username)
          expect(response_body["exp"]).to_not be_nil
        end
      end
      context "failure" do
        it "returns http unauthorized with username nil" do
          get "/authentications/login",
            params: { username: nil , password: '123456' }    
          
          expect(response).to have_http_status(:unauthorized)
          expect(response_body["error"]).to eq("unauthorized")
        end

        it "returns http unauthorized with password nil" do
          get "/authentications/login",
            params: { username: user.username, password: nil }    
          
          expect(response).to have_http_status(:unauthorized)
          expect(response_body["error"]).to eq("unauthorized")
        end

        it "returns http unauthorized with password wrong" do
          get "/authentications/login",
            params: { username: user.username, password: '9999999' }    
          
          expect(response).to have_http_status(:unauthorized)
          expect(response_body["error"]).to eq("unauthorized")
        end
      end
    end
  end
end