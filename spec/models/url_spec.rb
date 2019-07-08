require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:shorten) { Url.new(url: 'example.com') }
  
  it 'should generate a shortcode with a valid url' do
    shorten.save!
    
    expect(shorten).to be_valid
    expect(shorten.shortcode.size).to eq 6
    expect(shorten.shortcode).to match(/\A[0-9a-zA-Z_]{6}\z/)
  end
end
