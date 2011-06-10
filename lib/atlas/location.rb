# -*- coding: utf-8 -*-
module Atlas
  class Location
    extend ActiveSupport::Memoizable

    attr_accessor :name, :reference
    attr_accessor :words, :phonetics
    attr_accessor :zone

    def initialize(value_or_attributes, attributes = {})
      self.attributes = 
        self.class.extract_attributes(value_or_attributes).merge(attributes)
      self.reference ||= value_or_attributes
    end

    def attributes=(attributes = {})
      attributes.each { |k,v| send "#{k}=", v }
    end

    def reference_with_geocoding(geocoding = nil)
      reference = reference_without_geocoding
      # if geocoding and Road === reference 
      #   reference = Address.new(reference, geocoding.street_number) 
      # end
      reference
    end
    alias_method_chain :reference, :geocoding

    def self.from(value, attributes = {})
      unless Location === value
        Location.new(value, attributes)
      else
        unless attributes.empty?
          value = value.dup
          value.attributes = attributes
        end

        value
      end
    end

    def uid
      if reference
        reference.hash
      else
        to_s.hash
      end
    end
    memoize :uid

    def self.extract_attributes(value)
      return value if Hash === value

      {}.tap do |attributes|
        if value.respond_to?(:name)
          attributes[:name] = value.name 
        else
          attributes[:name] = value.to_s
        end
      end
    end

    def to_s
      zone ? "#{name}, #{zone}" : name
    end

    def eql(other)
      other and self.uid == other.uid
    end
    alias_method :==, :eql

    def words
      @words ||= name.to_words
    end

    def phonetics
      @phonetics ||= words.collect(&:phonetics).flatten
    end

    def zone_words
      zone ? zone.words : []
    end
    memoize :zone_words

    # def self.create_all
    #   Location.transaction do 
    #     Road.find_each do |road|
    #       Location.from(road).save!
    #     end
    #     (StopArea.commercial.without_parent + StopArea.stop_place.without_parent).each do |stop_area|
    #       Location.from(stop_area).save!
    #     end
    #     Place.find_each do |place|
    #       Location.from(place).save!
    #     end
    #   end
    # end

    def self.references(locations)
      # Location.find(locations, :include => "reference").sort_by do |location|
      #   locations.index(location)
      # end
      locations.collect!(&:reference)
    end

  end
end
