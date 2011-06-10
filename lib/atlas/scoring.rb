module Atlas
  class Scoring

    attr_accessor :score
    attr_reader :location

    def initialize(location)
      @location = Location.from(location)
      @score = 0
    end

    def to_s
      "#{@location} (#{score})"
    end

    delegate :uid, :to => :location

  end
end
