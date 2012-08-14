require 'spec_helper'

describe "Users" do
  describe "GET /" do
    it "goes to homepage" do
      visit root_url
      page.should have_content("networkmill keeps track of your contacts and makes")
    end
  end
end