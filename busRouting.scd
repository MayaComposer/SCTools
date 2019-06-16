// eli_snip_006 (Tut 7)

s.boot;
s.plotTree;
s.meter;   // levels

// instead of sending this to the speakers, send it to a bus
// declare the out buss indices, so you can reroute later
(
SynthDef.new(\blip, {
	arg out;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(300, 1200).round(300);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(2);
	sig = sig * EnvGen.kr(Env.perc(0.01, 0.2), trig);
	Out.ar(out, sig);

}).add;

SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 1);  // 1, here monophonic
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;  // !2 for 2 channels
	Out.ar(out, sig);
}).add;
)

// number of bus channels default 128 get from
// s.options.numAudioBusChannels;
// by default busses 0..7 are reserved for hardware outputs
// s.options.numOutputBusChannels;
// by default busses 8..15 are reserved for hardware inputs
// s.options.numInputBusChannels;
// changing these is done by assigning values , and then s.reboot;

s.options.numOutputBusChannels = 4;
s.options.numInputBusChannels = 2;
s.reboot;

y = Synth.new(\reverb, [\in, ~reverbBus], ~fxGroup);
x = Synth.new(\blip, [\out, ~reverbBus], ~sourceGroup);
x.free;
y.free;

~reverbBus = Bus.audio(s, 1);
~reverbBus.index;

~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);