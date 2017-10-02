module One
  def foo
    puts "One - Foo"
  end
end

module Two
  def foo
    puts "Two - Foo"
  end
end

class A
  include Two, One
end

A.new.foo