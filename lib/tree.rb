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
end

