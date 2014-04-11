require 'spec_helper'

describe "Static pages" do

  subject { page }

  let(:heading)    { 'Upload App' }
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    #it { should have_title(heading) }
  end

  describe "Home page" do
    before { visit root_path }

    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)     {'Help'}

    it { should have_content('Help') }
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)     {'About Us'}

    it { should have_content('About Us') }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)     {'Contact'}

    it { should have_content('Contact') }
    it_should_behave_like "all static pages"
  end

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_content('Sign in') }
    it { should have_selector('h2', "text: Sign in") }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_selector('h1', text: "About Us")
    click_link "Help"
    expect(page).to have_selector('h1', text: "Help")
    click_link "Contact"
    expect(page).to have_selector('h1', text: "Contact")
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_selector('h2', text: "Sign up")
    click_link "nicks upload app"
    expect(page).to have_selector('h1', text: "Welcome")
  end
end
