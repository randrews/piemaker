MidiOut mout;
MidiMsg msg;
// check if port is open
if( !mout.open( 0 ) ) me.exit();

0 => int message;
0 => int target;
0 => int color;

if( me.args() ){
  me.arg(0) => Std.atoi => message;
  me.arg(1) => Std.atoi => target;
  me.arg(2) => Std.atoi => color;
}

// fill the message with data
message => msg.data1;
target => msg.data2;
color => msg.data3;

mout.send( msg );
