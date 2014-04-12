# As a logged-in user, I see my image gallery so that I can manage photos.

# As a logged-in user on the image gallery index, I can click new to add another photo to bring up
# an image submission form.

# As a logged-in user on the image submission form, I can select an image file from my computer to
# upload it to the site.

# As a logged-in user on the image gallery index, I can click delete next to a picture so that I can
# remove it from the site.

# As a logged-in user on the image gallery index, I can click edit next to a picture so that I can
# apply a few basic image manipulation functions from Cloudinary.

#to do the edit story
#http://cloudinary.com/documentation/rails_carrierwave

require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Photo pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user, :scope => :user)
    visit root_path
  end

  it { should have_link('Sign out',    href: destroy_user_session_path) }
  it { should have_link('Photos',       href: photos_path) }
  it { should have_link('Settings',    href: edit_user_registration_path(user)) }
  it { should_not have_link('Sign in',    href: new_user_session_path) }



  Warden.test_reset! 
end
