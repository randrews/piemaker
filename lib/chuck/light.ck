MidiOut mout;
MidiMsg msg;
// check if port is open
if( !mout.open( 0 ) ) me.exit();

3 => int color;
if( me.args() ) me.arg(0) => Std.atoi => color;

// fill the message with data
176 => msg.data1;
0 => msg.data2;
color => msg.data3;

mout.send( msg );
