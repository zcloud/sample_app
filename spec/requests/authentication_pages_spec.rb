require 'spec_helper'

describe "Authentication" do
	
	subject { page }
	
	describe "signin" do
		before {visit signin_path}
		
		describe "before Signin" do			
			it { should have_selector('title', text: 'Sign in') }
			it { should have_selector('h1', text: 'Sign in') }
			it { should have_link('Sign up now!', href: signup_path) }
			it { should_not have_link('Sign out') }
			it { should_not have_link('Profile' ) }
		end

		describe "with invalid info" do
			before {click_button "Sign in"}
			
			it { should have_selector('title', text: 'Sign in') }
			it { should have_error_message('Invalid') }

			describe "after visiting another page" do
        before { click_link "Home" }
				it { should_not have_error_message }
      end
		end
		
		describe "with valid info" do
			let(:user) { FactoryGirl.create(:user) }
			
			before { sign_in(user) }
			
			it { should have_selector('title', text: user.name) }
			it { should have_link('Profile', href: user_path(user) ) }
			it { should have_link('Settings', href: edit_user_path(user) ) }
			it { should have_link('Sign out', href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }

			describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
		end
		
	
	end
	

describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end
    end
  end
end
