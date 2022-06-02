

class Flight

    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def full?
        return @passengers.length == @capacity
    end

    def board_passenger(passenger)
        if !self.full? && passenger.has_flight?(@flight_number)
            @passengers << passenger
        end
    end

    def list_passengers
        return @passengers.map {|el| el.name}
    end

    def [](idx)
        @passengers[idx]

    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end