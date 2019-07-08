class SetUrlTitleWorker
	include Sidekiq::Worker
	sidekiq_options retry: false
  
  def perform(id)
  	shortyUrl = Url.find(id)
    scrapped_url_title = Scrapper.new(shortyUrl.url).get_title
    
   	shortyUrl.update_attribute(:title, scrapped_url_title)
  end
end