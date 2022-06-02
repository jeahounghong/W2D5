

class Passenger

    attr_reader :name

    def initialize(name)
        @name = name
        @flight_numbers = []
    end

    def has_flight?(fn)
        return @flight_numbers.include?(fn.upcase)
    end

    def add_flight(fn)
        if !has_flight?(fn)
            @flight_numbers << fn.upcase
        end
    end


end