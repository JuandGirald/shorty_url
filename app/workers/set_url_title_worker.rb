class SetUrlTitleWorker
	include Sidekiq::Worker
	sidekiq_options retry: false
  
  def perform(url)
    scrapped_url_title = Scrapper.new(url).get_title

    shortyUrl = Url.find_by(url: url)
   	shortyUrl.update_attribute(:title, scrapped_url_title)
  end
end