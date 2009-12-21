require File.join(File.dirname(__FILE__), "util.rb")

module Piemaker
  MIDI_CK = File.join(File.dirname(__FILE__),"..","chuck","midi.ck")

  def self.new port = 8000
    Interface.new port
  end

  class Interface
    include Util
    include Commands

    attr_reader :chuck_pid, :port

    def initialize port = 8000
      @port = port

      @chuck_pid = fork do
        exec "chuck #{MIDI_CK}:#{port} --loop"
      end

      @socket = OSC::UDPSocket.new
    end

    def stop
      `kill -9 #{@chuck_pid}`
    end

    def send a, b, c
      msg = OSC::Message.new "/launchpad/midi", "iii", a, b, c
      @socket.send msg, 0, "localhost", @port
    end
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
