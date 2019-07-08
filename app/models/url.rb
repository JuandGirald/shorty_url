class Url < ApplicationRecord
	validates_presence_of :url
	before_validation :check_protocol, :generate_shortcode, on: :create



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
	    self.url = "http://#{url}" unless URI.parse(url).scheme
	  end
end
