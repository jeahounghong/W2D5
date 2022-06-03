require_relative 'list.rb'
require_relative 'item.rb'

class TodoBoard

    attr_reader :list

    def initialize()
        @lists = {}

    end

    def mklist(label)
        return false if @lists.has_key?(label)
        @lists[label] = List.new(label)
    end

    def ls
        @lists.each do |k,v|
            puts k
        end
    end

    def showall
        puts
        @lists.each do |k,v|
            puts k.upcase
            v.print
            puts
        end
    end

    def mktodo(label, title, deadline, description = nil)
        #d = ((done == "true" || done == "TRUE") ? true : false)
        return false if !@lists.has_key?(label)
        @lists[label].add_item(title, deadline, description = nil)
        # @list.add_item(title, deadline, description)
        return true
    end

    def up(label ,idx, amt)
        @lists[label].up(idx,amt)
        return true
    end

    def down(label, idx, amt)
        @lists[label].down(idx, amt)
        return true
    end

    def swap(label,idx1, idx2)
        @lists[label].swap(idx1, idx2)
        return true
    end

    def priority(label)
        return false if !@lists.has_key?(label)
        @lists[label].priority
        return true
    end

    def purge(label)
        return false if !@lists.has_key?(label)
        @lists[label].purge
        return true
    end

    def pt(label,idx=nil)
        return false if !@lists.has_key?(label)

        if idx == nil
            @lists[label].print
        else
            idx = idx.to_i
            @lists[label].print_full_item(idx)
        end
        # @list.print(idx)
        return true
    end

    def quit
        false
    end

    def togg(label, i)
        @lists[label].toggle_item(i)
    end

    def rm(label, i)
        return false if !@lists.has_key?(label)
        @lists[label].remove(idx)
        return true
    end

    def get_command
        puts "Enter a command:"
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            if args[0] == nil
                puts "Enter a list label after 'mklist'"
                return true
            end
            self.mklist(args[0])
        when 'ls'
            self.ls
        when 'showall'
            self.showall
        when 'mktodo'
            self.mktodo(*args)
            # @list.add_item(*args)
        when 'print'
            self.pt(args[0], args[1])
            true
        when 'priority'
            self.priority(args[0])
            true
        when 'swap'
            self.swap(args[0], args[1].to_i, args[2].to_i)
            true
        when 'up'
            self.up(args[0], args[1].to_i, args[2].to_i)
            #@list.up(args[0].to_i, args[1].to_i)
            true
        when 'down'
            self.down(args[0], args[1].to_i, args[2].to_i)
            #@list.down(args[0].to_i, args[1].to_i)
            true
        when 'toggle'
            #p args[1].to_i
            self.togg(args[0],args[1].to_i)
            true
        when 'purge'
            self.purge(args[0])
        when 'rm'
            self.remove(args[0], args[1].to_i)
        when 'quit'
            return false
        else
            puts "Sorry, that command is not recognized."
        end
        true
    end

    def run
        turn = true
        while turn do
            turn = get_command
        end
    end 

end

# str = "sdfsdf"
# print "    " + str


mb = TodoBoard.new()
mb.run