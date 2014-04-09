#[x] As a new visitor to the site, I can sign up so that I have an account.
#[x] As a logged-in user, I can click logout to end my session.
#[x] As a return user, I can log in to the site to access my account.
# As a visitor to the site, I can reset my password by entering my email address.
# if you ever wanna get that last user story working:
# http://ridingrails.net/devise-authentication-recover-password-email-code-kata/

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signup" do

    before { visit new_user_registration_path }

    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before do
          fill_in "user_email",                  with: ""
          fill_in "user_password",               with: ""
          fill_in "user_password_confirmation",  with: ""
          click_button submit
        end
        it { should have_content('Sign up') }
        it { should have_content('prohibited this user from being saved:') }
        it { should have_content("Email can't be blank")}
        it { should have_content("Password can't be blank")}
      end
    end
    describe "with valid information" do
      before do
        fill_in "user_email",                 with: "upload@nicksdevspot.com"
        fill_in "user_password",              with: "asdfasdf"
        fill_in "user_password_confirmation", with: "asdfasdf"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'upload@nicksdevspot.com') }

        it { should have_link('Sign out') }
        it { should have_content('Welcome') }
        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end

        # describe "forgotten password" do
        #   before do
        #     click_link "Sign out"
        #     visit new_user_session_path
        #     click_link "Forgot your password?"
        #   end
        #   it { should have_selector('h2', text:'Forgot your password?') }

        #   describe "should send out email with instructions" do
        #     before do
        #       fill_in "user_email",    with: 'upload@nicksdevspot.com'
        #       click_button "Send me reset password instructions"
        #     end
        #     it { should have_content('You will receive an email with instructions on how to reset your password in a few minutes.') }
        #   end
        # end

        describe "signin" do
          before do
            click_link "Sign out"
            visit new_user_session_path
          end
          #let(:user) { FactoryGirl.create(:user) }
          let(:user) { User.find_by(email: 'upload@nicksdevspot.com') }

          describe "with invalid information" do
            before { click_button "Sign in" }

            it { should have_content('Sign in') }
            it { should_not have_link('Profile') }
            it { should_not have_link('Settings',    href: edit_user_registration_path(user)) }

            describe "after visiting another page" do
              before { click_link "Home" }
              it { should_not have_selector('div.alert.alert-error') }
            end
          end
          describe "with valid information" do
            before do
              #fill_in "user_email",    with: user.email.upcase
              #fill_in "user_password", with: user.encrypted_password
              fill_in "user_email",    with: 'upload@nicksdevspot.com'
              fill_in "user_password", with: 'asdfasdf'
              click_button "Sign in"
            end

            it { should have_link('Photos',       href: photos_path) }
            it { should have_link('Profile') }
            it { should have_link('Settings',    href: edit_user_registration_path(user)) }
            it { should have_link('Sign out',    href: destroy_user_session_path) }
            it { should_not have_link('Sign in', href: new_user_session_path) }
          end
        end
      end
    end
  end
end
