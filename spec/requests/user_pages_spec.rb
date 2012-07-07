require 'spec_helper'

describe "User pages" do

  subject { page }

	describe "profile page" do
		let(:user) {FactoryGirl.create(:user) }
		before { visit user_path(user) }
		
		it { should have_selector('h1', text:user.name) }
		it { should have_selector('title', text:user.name) }
	end

  describe "signup" do 
		before { visit signup_path } 
		
		let(:submit) { "Create my account" } 
		
		describe "with invalid information" do 
			
			it "should not create a user" do 
				expect { click_button submit }.not_to change(User, :count) 
			end 

			describe "error messages" do
				describe "empty name" do
					before do
						fill_in "Name", with: ""
						fill_in "Email", with: "user1@example.com"
						fill_in "Password", with: "foobar"
						fill_in "Confirmation", with: "foobar"
						click_button submit 
					end
					it { should have_selector('title', text: 'Sign up') }
					it { should have_content('error') }
					it { should have_content("Name can't be blank") }
				end
				
				describe "empty email" do
					before do
						fill_in "Name", with: "test user"
						fill_in "Email", with: ""
						fill_in "Password", with: "foobar"
						fill_in "Confirmation", with: "foobar"
						click_button submit 
					end
					it { should have_selector('title', text: 'Sign up') }
					it { should have_content('error') }
					it { should have_content("Email can't be blank") }
				end
				
				describe "empty password" do
					before do
						fill_in "Name", with: "test user"
						fill_in "Email", with: "test@test.com"
						fill_in "Password", with: ""
						fill_in "Confirmation", with: "foobar"
						click_button submit 
					end
					it { should have_selector('title', text: 'Sign up') }
					it { should have_content('error') }
					it { should have_content("Password can't be blank") }

				end
				
				describe "empty password confirmation" do
					before do
						fill_in "Name", with: "test user"
						fill_in "Email", with: "user1@example.com"
						fill_in "Password", with: "foobar"
						fill_in "Confirmation", with: ""
						click_button submit 
					end
					it { should have_selector('title', text: 'Sign up') }
					it { should have_content('error') }
					it { should have_content("Password confirmation can't be blank") }
				end
				
				describe "short password" do
					before do
						fill_in "Name", with: "test user"
						fill_in "Email", with: "user1@example.com"
						fill_in "Password", with: "foo"
						fill_in "Confirmation", with: "foo"
						click_button submit 
					end
					it { should have_selector('title', text: 'Sign up') }
					it { should have_content('error') }
					it { should have_content("Password is too short (minimum is 6 characters)") }
				end
			end
		end 
		
		describe "with valid information" do 
			describe "unique email" do
				before do
					fill_in "Name", with: "test user"
					fill_in "Email", with: "user@example.com"
					fill_in "Password", with: "foobar"
					fill_in "Confirmation", with: "foobar"
				end
			
				it "should create a user" do 
					expect { click_button submit }.to change(User, :count).by(1) 
				end
				
				describe "after saving the user" do
					before { click_button submit }
					let(:user) { User.find_by_email('user@example.com') }
					it { should have_selector('title', text: user.name) }
					it { should have_selector('div.alert.alert-success', text: 'Welcome') }
				end
			end
		end
	end
end