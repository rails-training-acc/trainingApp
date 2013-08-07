require 'spec_helper'

describe "Authentication" do
  
  subject { page }

  describe "validates signin page look" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('h3', text: 'Invalid') }
    end # invalid information 

    describe "with valid info" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end # with valid info
  end

  describe "authorize" do

    describe "non signed-in user" do
      
      let(:user) { FactoryGirl.create(:user) }

      describe "visiting edit page" do
        before { visit edit_user_path(user) }

        it { should have_selector('title', text: 'Sign in') }
      end # visit edit

    end # non signed in
  end # authorize
end


