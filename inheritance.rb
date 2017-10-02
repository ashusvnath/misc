class Parent
  def self.inherited(descendant)
    puts "Parent inherited by #{descendant}"
  end
end

class Child < Parent
  def self.inherited(descendant)
    puts "Child inherited by #{descendant}"
    super(descendant)
  end
end

class GrandChild < Child
end

