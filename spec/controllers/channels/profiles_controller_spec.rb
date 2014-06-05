require 'spec_helper'

describe Channels::ProfilesController do
  subject{ response }
  let(:channel){ FactoryGirl.create(:channel, permalink: 'sample') }

  describe "GET show" do
    before do
      request.stub(:subdomain).and_return(channel.permalink)
      get :show, id: 'sample', locale: "pt"
    end

    its(:status){ should == 200 }
  end
end

