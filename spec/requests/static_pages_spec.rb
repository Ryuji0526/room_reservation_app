require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "successful visit root_path" do
      get root_path
      expect(response).to be_successful
    end
  end
end
