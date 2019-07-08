require 'spec_helper'
require 'rails_helper'

feature 'Url management' do
  context 'enter valid url' do
    let(:url) { 'https://www.marvel.com/articles/movies/jon-watts-on-how-spider-man-far-from-home-became-european-vacation' }

    scenario 'Creates a shorty url' do
      visit root_path

      fill_in 'url[url]', with: url
      click_button "Create"

      shortUrl = Url.first

      expect(page).to have_content url
      expect(page).to have_content shortUrl.shortcode
    end
  end

  context 'When enter a right shorty url' do
    let(:url) { Url.create(url: 'https://www.bluecoding.com/join-our-team') }
    
    scenario 'Url access increase and redirect to corresponding URL' do
      visit redirect_path(shortcode: url.shortcode)

      url.reload

      expect(url.access).to eq(1)
      expect(current_url).to eq(url.url)
    end
  end

  context 'When enter a wrong shorty url' do
    scenario 'Shows error page' do
      visit redirect_path(shortcode: 'asd')

      expect(page).to have_content 'Sorry, an error has occured, Requested page not found!'
    end
  end

  context 'With 200 shorty urls created' do
    before { FactoryGirl.create_list(:url, 200, :accessed) }
    
    scenario 'Shows the top 100' do
      visit root_path

      expect(page).to have_css("table tbody tr", count: 100)
    end
  end
end
