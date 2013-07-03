require 'spec_helper'

describe "StaticPages" do

  let(:proj_title) { "ShuffleBoard" }
  subject { page }

  describe "Home page" do

    before(:each) { visit root_path }

    it "should have content 'ShuffleBoard'" do
      should have_content("#{proj_title}")
    end

    it "should have selector 'h2' with 'We love Ruby'" do
      should have_selector('h2', :text=>"We love Ruby")
    end
  end

  describe "Help page" do
    it "should have selector h1 with text 'ShuffleBoard | Help Page'" do
      visit help_path
      should have_selector('h1', :text=>"#{proj_title} | Help Page")
    end
  end

  describe "Contacts page" do
    it "should have content ShuffleBoard" do
      visit contacts_path
      should have_content("#{proj_title}")
    end
  end
end
