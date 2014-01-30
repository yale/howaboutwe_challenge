require 'rspec'
require 'pry'

class Array
  def my_average
    counts = {}
    max = min = self.first
    size = 0
    sum = 0
    
    self.each do |i|
      max = i if i > max 
      min = i if i < min
      size += 1
      sum += i
      if counts[i] 
        counts[i] += 1 
      else 
        counts[i] = 1 
      end
    end

    [max, min].each do |n|
      sum  -= counts[n]*n
      size -= counts[n]
    end

    sum/size
  end
end

describe Array, "#my_average" do
  let(:ex1) { [3, 9, 15, 3, 9, 6, 6, 3, 15, 5] }
  let(:ex2) { [1, 2, 3, 4, 5] }
  let(:ex3) { [-4, -1000, 15, 0, 99999] }
  
  it { ex1.my_average.should eq 7 }
  it { ex2.my_average.should eq 10/3 }
  it { ex3.my_average.should eq 11/3 }
end
