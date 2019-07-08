class Scrapper
  def initialize(url)
    doc = HTTParty.get(url, verify: false)
    @parse_page ||= Nokogiri::HTML::Document.parse(doc.body)
  end
  
  def get_title
    @parse_page.title
  end
end