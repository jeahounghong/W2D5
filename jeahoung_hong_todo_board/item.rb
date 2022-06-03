

class Item

    attr_accessor :title, :description
    attr_reader :deadline, :done
    def initialize(title, deadline, description)
        @title = title
        unless Item.valid_date?(deadline)
            raise ArgumentError.new "Not a valid date"
        end
        @deadline = deadline
        @description = description
        @done = false
    end

    def toggle
        @done = !@done
    end

    def deadline=(val)
        @deadline = val if Item.valid_date?(val)
    end

    def self.valid_date?(data_string)
        
        return false if data_string.length != 10
        return false if data_string[4] != "-" || data_string[7] != "-"

        arr = [0,1,2,3,5,6,8,9]
        arr.each do |i|
            return false if data_string[i].to_i.to_s != data_string[i]
        end
        return false if (data_string[5].to_i * 10 ) + data_string[6].to_i > 12
        return false if (data_string[8].to_i * 10 ) + data_string[9].to_i > 31 || (data_string[8].to_i * 10 ) + data_string[9].to_i < 1
        true
    end

end

# b = Item.new("Eggs","1999-10-10",  "Description for Eggs")