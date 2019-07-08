class Url < ApplicationRecord
  before_validation :check_protocol, :generate_shortcode, on: :create
  after_create :set_url_title
  validates :url, presence: true
  validates :shortcode,
            uniqueness: { case_sensitive: true,
                          message: 'The the desired shortcode is already in use. Shortcodes are case-sensitive.' }

  scope :top, ->(limit) { order('access desc').limit(limit) }

  def self.process(shortcode)
    return unless url = Url.find_by(shortcode: shortcode)

    url.increment!(:access)
  end

  private
    def set_url_title
      SetUrlTitleWorker.perform_async(self.id)
    end
    # generate a shortcode to match ^[0-9a-zA-Z_]{6}$
    def generate_shortcode
      unless shortcode
        begin 
          unique_code = ([
            ('a'..'z').to_a, 
            ('A'..'Z').to_a, 
            ('0'..'9').to_a].
            flatten).sort_by{rand}[0, 6].join
        end until(not self.class.find_by(shortcode: unique_code))
        
        self.shortcode = unique_code
      end
    end

    # check url protocol and add https if none
    def check_protocol
      return if url.blank?
      self.url = "http://#{url}" unless URI.parse(url).scheme
    end
end
