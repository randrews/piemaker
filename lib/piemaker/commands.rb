require File.join(File.dirname(__FILE__), "util.rb")

module Piemaker::Commands
  include Piemaker::Util

  def reset
    send 176, 0, 0
  end

  def []= x, y, color
    send 144, button(x,y), color
  end

  def bulkload values
    (0..(values.size/2)).each do |idx|
      send 146, values[idx*2], values[idx*2+1]
    end
    noop
  end

  def noop
    send 128, 0, 0
  end

  def glow num = 100
    colors = [RED1, RED2, RED3, RED2]
    state = (0..79).map{|n| rand(colors.size)}

    num.times do |gen|
      bulkload state.map{|c| colors[(c+gen) % colors.size] }
    end
  end
end
