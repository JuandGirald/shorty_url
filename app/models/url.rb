class Url < ApplicationRecord
  validates :url, presence: true
  before_validation :check_protocol, :generate_shortcode, on: :create

  scope :top, ->(limit) { order('access desc').limit(limit) }

  def self.process(shortcode)
    url = Url.find_by(shortcode: shortcode)
  end

  private
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
