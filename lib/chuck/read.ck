#!/usr/local/bin/chuck

// number of the device to open (see: chuck --probe)
0 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// the midi event
MidiIn min;
MidiOut mout;
// the message for retrieving data
MidiMsg msg;
MidiMsg msgout;

// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

if( !mout.open( min.num() ) ) me.exit();

// infinite time-loop
while( true )
{
    // wait on the event 'min'
    //min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;

    144 => msgout.data1;
    0 => msgout.data2;
    3 => msgout.data3;
    mout.send(msgout); 

    }
}
