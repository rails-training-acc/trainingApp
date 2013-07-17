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

  describe "edit page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',    text: "Update this profile:") }
      it { should have_selector('title', text: "ShuffleBoard | Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_content(new_name) }
      it { should have_content(new_email) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end

  end

  describe "index" do
    before do
      FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_selector('title', text: 'ShuffleBoard | Users') }
    it { should have_selector('h2',    text: 'All users:') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('td', text: user.name)
        page.should have_selector('td', text: user.email)
      end
    end

    describe "delete links" do
      it { should have_link('Delete', href: user_path(User.first)) }
      it "should be able to delete another user" do
          expect { click_link('Delete') }.to change(User, :count).by(-1)
      end
    end

  end

end
