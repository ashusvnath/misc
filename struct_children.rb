class Struct
  @descendants = []
  def self.inherited(descendant)
    @descendants << descendant
  end

  def self.descendants
    @descendants
  end
end

Fred = Struct.new(:name, :age)
Dave = Struct.new(:height, :weight)
Smith = Struct.new(:foo, :bar)


puts Fred.class 
# class MiniFred < Fred
# end

puts Struct.descendants
#puts Fred.descendants