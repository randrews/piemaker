module Piemaker
  SEND_CK = File.join(File.dirname(__FILE__),"..","chuck","send.ck")
  LIGHT_CK = File.join(File.dirname(__FILE__),"..","chuck","light.ck")

  LIGHT = 0x90
  RED = 3
  GREEN = 48
  YELLOW = 51

  def self.start
    fork do
      exec "chuck --loop"
    end
  end

  def self.stop pid
    `kill -9 #{pid}`
  end

  def self.run
    pid = start
    send 176, 0, 0
    yield
    stop pid
  end

  def self.send message, target, color
    fork do 
      exec "chuck + #{SEND_CK}:#{message}:#{target}:#{color}"
    end
  end

  def self.light colors
    args = colors.map{|k,v| "#{k}:#{v}"}.join ":"

    Thread.new do
      `chuck + #{LIGHT_CK}:#{args}`
    end
  end

  def self.button x, y
    16*y + x
  end

  def self.fire
    colors = {}

    8.times do |y|
      8.times do |x|
        colors[button(x,y)] = rand(3)+1
      end
    end

    light colors
  end
end
