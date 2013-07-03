require 'spec_helper'

describe "StaticPages" do

  let(:proj_title) { "ShuffleBoard" }

  describe "Home page" do

    it "should have content 'ShuffleBoard'" do
      visit '/static_pages/home'
      page.should have_content("#{proj_title}")
    end

    it "should have selector 'p' with 'I love Ruby'" do
      visit '/static_pages/home'
      page.should have_selector('p', :text=>"I love Ruby")
    end
  end

  describe "Help page" do
    it "should have selector h1 with text 'ShuffleBoard | Help Page'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text=>"#{proj_title} | Help Page")
    end
  end

  describe "Contacts page" do
    it "should have content ShuffleBoard" do
      visit '/static_pages/contacts'
      page.should have_content("#{proj_title}")
    end
  end
end
