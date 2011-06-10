module Atlas
  class Zone # < ChouetteActiveRecord
    # set_table_name :geocoder_zones

    extend ActiveSupport::Memoizable

    attr_accessor :name
    attr_accessor :uid 

    def initialize(attributes = {})
      attributes.each { |k,v| send "#{k}=", v }
      self.after_initialize
    end

    # def self.find_by_insee(insee)
    #   Zone.find_by_uid(insee) or 
    #     Zone.find_by_city(City.find_by_insee_code(insee))
    # end

    # def self.find_by_city(city)
    #   return nil if city.nil?
    #   Zone.find_or_create_by_uid(:uid => city.insee_code, :name => city.name)
    # end

    def after_initialize
      # to make easier tests
      self.uid ||= name.hash
    end

    def to_s
      name
    end

    def words
      name.to_words
    end
    memoize :words

    def ==(other)
      other and uid == other.uid
    end

  end
end

