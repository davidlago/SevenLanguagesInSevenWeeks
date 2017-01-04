class Tree
  attr_accessor :children, :node_name

  def initialize(tree_structure)
    # Not killing myself here, not accounting for trees with several top-level
    # nodes
    first_node_name = tree_structure.first[0]
    first_nodes_children = tree_structure.first[1]

    @node_name = first_node_name
    @children = {}

    if first_nodes_children.any?
      @children = first_nodes_children.map do |name, children|
        Tree.new({"#{name}" => children})
      end
    end
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end
end

MY_TREE = {
  'grandpa' => {
    'dad' => {
      'child 1' => {},
      'child 2' => {}
    },
    'uncle' => {
      'child 3' => {},
      'child 4' => {}
    }
  }
}

ruby_tree = Tree.new(MY_TREE)

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}
