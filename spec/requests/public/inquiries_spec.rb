require 'rails_helper'

RSpec.describe "Public::Inquiries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/public/inquiries/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /confirm" do
    it "returns http success" do
      get "/public/inquiries/confirm"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /thanks" do
    it "returns http success" do
      get "/public/inquiries/thanks"
      expect(response).to have_http_status(:success)
    end
  end

end
