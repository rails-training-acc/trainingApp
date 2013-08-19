require 'spec_helper'

describe "SearchPages" do 

	subject {page}

	before do 
		FactoryGirl.create(:user)
	end
		
	describe "successful search" do
		before { visit root_path }
		it {should have_selector('input', name: "search")}
		
		before do
			fill_in "search" , with: "Doe"
			click_button "submit_button"
		end
	
		it { should have_selector('h2',    text: "Found these users:") }	
		it { should have_content("john@doe.com") }	
	end

	describe "unseccesful search" do
		before { visit root_path }
		it {should have_selector('input', name: "search")}
		
		before do
			fill_in "search" , with: "fake data"
			click_button "submit_button"
		end
	
		it { should have_selector('h2',    text: "Did not find anything :(") }	
	end

end