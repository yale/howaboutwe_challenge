require 'rspec'
require 'pry'
require 'benchmark'

class Array
  def my_flatten
    [].deep_push(self)
  end
  
  def deep_push x
    unless x.kind_of?(Array)
      self << x
    else 
      x.each { |e| deep_push e } 
    end
    self
  end
end

describe Array, '#my_flatten' do
  it "is self if empty array" do
    [].my_flatten.should == []
  end

  it "is self if already flat" do
    [1, 2].my_flatten.should == [1, 2]
  end

  it "flattens an array" do
    [1, [2, 3], 4].my_flatten.should == [1, 2, 3, 4]
  end

  it "flattens an array with depth 3" do
    [:a, ["b", 1, [:c, 3]], "d"].my_flatten.should == [:a, "b", 1, :c, 3, "d"]
  end

  it "flattens a deep singleton array" do
    [[[[[[[[[[:win]]]]]]]]]].my_flatten.should == [:win]
  end

  it "performs decently compared to #flatten" do
    big = [1, [2, 3, 4], 5, [[6, 7, [[[[8, 9], 10], 11], 12]], 13], 14]
    flatten    = Benchmark.realtime { big.flatten    }
    my_flatten = Benchmark.realtime { big.my_flatten }
    # We can be a little bit slower than flatten
    (flatten/my_flatten).should be > 0.9
  end
end
