MidiOut mout;
MidiMsg msg;
if( !mout.open( 0 ) ) me.exit();

OscRecv recv;
me.arg(0) => Std.atoi => recv.port;
recv.listen();

recv.event("/launchpad/midi, i i i") @=> OscEvent @ oe;

while(true){
  oe => now;
  while(oe.nextMsg()){
    oe.getInt() => msg.data1;
    oe.getInt() => msg.data2;
    oe.getInt() => msg.data3;

    mout.send( msg );
  }
}
