require 'spec_helper'

describe Photo do

  before do
    @photo = Photo.new(title: "My photo #1", user_id: 1, image: "v1396981160/vhbogssdfatdyhgyfnmm.jpg", bytes: 211141)
  end

  subject { @photo }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:image) }
  it { should respond_to(:bytes) }

end