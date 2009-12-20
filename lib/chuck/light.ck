MidiOut mout;
MidiMsg msg;
// check if port is open
if( !mout.open( 0 ) ) me.exit();

144 => msg.data1;
0 => int target;
0 => int color;

0 => int idx;

if( me.args() ){
  while(idx < me.args()){
    <<< me.args() >>>;
    me.arg(idx) => Std.atoi => target;
    me.arg(idx+1) => Std.atoi => color;
    target => msg.data2;
    color => msg.data3;
    mout.send( msg );
    (idx + 2) => idx;
  }
}
