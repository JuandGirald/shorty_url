require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:subject) { Url.new(url: 'example.com') }

  it 'is not valid without a url' do
    subject.url = nil
    expect(subject).to_not be_valid
  end
  
  it 'should generate a shortcode with a valid url' do
    subject.save!
    
    expect(subject).to be_valid
    expect(subject.shortcode.size).to eq 6
    expect(subject.shortcode).to match(/\A[0-9a-zA-Z_]{6}\z/)
  end
end
