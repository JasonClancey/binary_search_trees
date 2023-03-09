class Tree

    require_relative 'node'
    attr_accessor :root

    def initialize(array)
        sorted_unique = array.uniq.sort
        @root = build_tree(sorted_unique)
    end

    def build_tree(array)
        return nil if array.empty?

        mid = array.length / 2
        root = Node.new(array[mid])
        root.left = build_tree(array[0...mid])
        root.right = build_tree(array[(mid + 1)..-1])
        root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert(value, node = @root)
        return @root = Node.new(value) if @root.nil?

        if value < node.data
            node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
        else
            node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
        end
    end

    def delete(value, node = @root)
        return node if node.nil?

        if value < node.data
            node.left = delete(value, node.left)
        elsif value > node.data
            node.right = delete(value, node.right)
        else
            if node.left.nil?
                return node.right
            elsif node.right.nil?
                return node.left
            else
                left_node = min_value_in_right_tree(node.right)
                node.data = left_node.data
                node.right = delete(left_node.data, node.right)
            end
        end
        node
    end


    def min_value_in_right_tree(node)
        current = node
        while current.left.nil? == false
            current = current.left
        end
        current
    end

    def find(value, node = @root)
        return node if node.nil? || node.data == value

        value < node.data ? find(value, node.left) : find(value, node.right)
    end

end

