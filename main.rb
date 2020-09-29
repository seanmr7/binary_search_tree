require_relative 'lib/tree.rb'

# Create new tree with an array of 15 random values between 1 and 100
tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
tree.balanced? ? (puts 'True') : (puts 'False')

# Test level-order, pre-order, post-order, and inorder transversal methods
puts "Level-order transversal: #{tree.level_order}"
puts "Pre-order transversal: #{tree.preorder}"
puts "Post-order transversal: #{tree.postorder}"
puts "In-order transversal: #{tree.inorder}"

# Add values to unbalance the tree.
tree.insert(200)
tree.insert(125)
tree.insert(139)
tree.insert(350)
tree.insert(893)
tree.pretty_print

# Confirm tree is unbalanced, rebalance the tree, and confirm it is balanced.
tree.balanced? ? (puts 'True') : (puts 'False')
tree.rebalance
tree.balanced? ? (puts 'True') : (puts 'False')
tree.pretty_print

# Print rebalanced tree in level-order, pre-order, post-order, and inorder
puts "Level-order transversal: #{tree.level_order}"
puts "Pre-order transversal: #{tree.preorder}"
puts "Post-order transversal: #{tree.postorder}"
puts "In-order transversal: #{tree.inorder}"