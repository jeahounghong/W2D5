require_relative 'item.rb'

class List

attr_accessor :label, :items

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = nil)
        begin
            @items << Item.new(title, deadline, description)
            return true
        rescue
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(idx)
        return idx < self.size || idx >= 0
    end

    def swap(idx1, idx2)
        return false if !self.valid_index?(idx1) || !self.valid_index?(idx2)

        temp = @items[idx1]
        @items[idx1] = @items[idx2]
        @items[idx2] = temp
        return true
    end

    def [](idx)
        return nil if !self.valid_index?(idx)
        return @items[idx]
    end

    def priority
        return print_full_item(0)
    end

    def print
        @items.each_with_index do |el,i|
            puts (i+1).to_s + "  " + el.title.to_s + "    " + el.deadline + "   "+ (el.done ? "DONE" : "NOT DONE")
        end
    end

    def print_full_item(idx)
        return false if !valid_index?(idx)
        item = @items[idx]

        puts
        puts "------------------------------\n"
        puts item.title.to_s + "              " + item.deadline.to_s
        puts item.description.to_s
        puts 
        str = item.done ? "YES" : "NO"
        puts "Done?  :  " + str
        puts "------------------------------\n"
        puts


    end

    def print_priority
        if !self.valid_index?(0)
            puts "No more items on list " + @label
            return false
        end
        self.print_full_item(0)
    end

    def up(idx, amt)
        return false if amt > idx
        new_idx = idx - amt
        # arr = []
        # p @items
        # arr << @items[idx]
        #p "HI"
        @items = @items[0...new_idx] + [ @items[idx] ] + @items[new_idx ... idx] + @items[idx + 1 .. -1]

        #@items = [@item[idx]] + @items[0...idx] + @items[idx + 1..-1]
    end

    def down(idx,amt)
        return false if @items.length - idx - 1 < amt
        new_idx = idx + amt
        @items = @items[0...idx] + @items[idx+1 .. new_idx] + [ @items[idx] ] + @items[new_idx + 1 ..-1]
    end

    def sort_by_date!
        arr = @items.sort_by! do |item|
            date = item.deadline[0...4] + item.deadline[5..6] + item.deadline[8..9]
            date.to_i
        end
        arr
    end

    def toggle_item(idx)
        return false if !valid_index?(idx)
        @items[idx].toggle
        true
    end

    def remove(idx)
        return false if !valid_index?(idx)
        @items.slice!(idx)
    end

    def purge
        arr = []
        @items.each do |el|
            if !el.done
                arr << el
            end
        end
        @items = arr
    end


end

# b = List.new("Shopping List")
# b.add_item("Eggs", "1999-02-10","Description for Eggs")
# b.add_item("Milk", "1999-10-11","Description for Milk")
# b.add_item("Onions", "2000-10-09","Description for Onions")
# b.print
# b.up(1,1)
# puts
# b.sort_by_date!
# b.print
