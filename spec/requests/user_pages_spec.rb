require 'spec_helper'

describe "UserPages" do
  describe "GET /signup" do
    it "responds with status 200" do
      get signup_path
      response.status.should be(200)
    end
  end

  subject {page}

  describe "signup page" do
  
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: 'ShuffleBoard | Sign up') }

  end
end
