require_relative 'node.rb'

class Tree
  attr_accessor :root

  def initialize(array)
    array = array.sort.uniq
    @root = build_tree(array, 0, array.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def build_tree(arr, start, endof)
    return root if start > endof

    if arr.size == 1
      Node.new(arr[0])
    else
    mid = (start + endof) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr, start, mid - 1)
    root.right = build_tree(arr, mid + 1, endof)
    return root
    end
  end

  def find_min(root = @root)
    if root.left != nil
      find_min(root.left)
    else
      return root
    end
  end

  def delete(value, root = @root)
    return if root.nil?

    if root.data > value
      root.left = delete(value, root.left)
    elsif root.data < value
      root.right = delete(value, root.right)
    else
      # Delete node with zero or one branch
      if root.left.nil?
        temp_root = root.right
        root = nil
        return temp_root
      elsif root.right.nil?
        temp_root = root.left
        root = nil
        return temp_root
      end
      # Delete node with two branches
      temp_root = find_min(root.right)
      temp_root_value = temp_root.data
      delete(temp_root_value)
      root.data = temp_root_value
      return root
    end
    root
  end

  def preorder(root = @root)
    return if root.nil?

    array = []
    array << root.data
    array << preorder(root.left) unless root.left.nil?
    array << preorder(root.right) unless root.right.nil?
    array.flatten
  end

  def inorder(root = @root)
    return if root.nil?

    array = []
    array << inorder(root.left) unless root.left.nil?
    array << root.data
    array << inorder(root.right) unless root.right.nil?
    array.flatten
  end

  def postorder(root = @root)
    return if root.nil?

    array = []
    array << postorder(root.left) unless root.left.nil?
    array << postorder(root.right) unless root.right.nil?
    array << root.data
    array.flatten
  end

  def level_order
    root = @root
    queue = []
    array = []
    current = 0
    return if root.nil?
    queue.unshift(root)
    while queue.empty? == false
      current_root = queue.pop
      array[current] = current_root.data
      current += 1
      queue.unshift(current_root.left) unless current_root.left.nil?
      queue.unshift(current_root.right) unless current_root.right.nil?
    end
    array
  end

  def insert(value, root = @root)
    if root.nil?
      return Node.new(value)
    else
      if root == value
        return root
      elsif root.data > value
        root.left = insert(value, root.left)
      elsif root.data < value
        root.right = insert(value, root.right)
      end
    end
    root
  end

  def find(value, root = @root)
    if root.data == value
      root
    elsif value > root.data && root.right != nil
      find(value, root.right)
    elsif value < root.data && root.left != nil
      find(value, root.left)
    else
      false
    end
  end

  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    if left_height > right_height
      return left_height + 1
    else
      return right_height + 1
    end
  end

  def depth(node, root = @root)
    return 0 if node.data == root.data

    if node.data < root.data
      return depth(node, root.left) + 1
    else
      return depth(node, root.right) + 1
    end
  end

  def balanced?
    return true if root.nil?

    if  balanced_utility(root) &&
        balanced_utility(root.left) &&
        balanced_utility(root.left)
      true
    else
      false
    end
  end

  def balanced_utility(root = @root)
    return true if root.nil?

    left_height = height(root.left)
    right_height = height(root.right)
    difference = left_height - right_height
    if difference <= 1 && difference >= -1
      true
    else
      false
    end
  end

  def rebalance
    if self.balanced?
      return "Tree is already balance"
    else
      array = level_order.sort.uniq
      @root = nil
      @root = build_tree(array, 0, array.length - 1)
    end
  end
end
