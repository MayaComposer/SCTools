(
[6, 4, 0.5, 10, 7].do{
	arg item;
	item.squared.postln;}
)

z = [6, 5, 0.5, 10, 7].collect(_.squared);

x = {VarSaw.ar(40!2, 0, 0.05, 0.1)}.play;
x.free;

(
SynthDef.new(\iter, {
	arg freq = 40;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(
		Env.perc(0.5, 5, 1, -2),
		doneAction:2
	);
	20.do{
		temp = VarSaw.ar(
			freq * {Rand(0.99,1.02)}!2,
			{Rand(0.0, 1.0)}!2,
			{ExpRand(0.005, 0.05)}!2
		);
		sum = sum + temp;
	};
	sum = sum * 0.025 * env;
	Out.ar(0, sum)
}).add;
)

y = Synth.new(\iter, [\freq, 200]);
y.free;

s.options.numAudioBusChannels;
s.options.numOutputBusChannels;
s.options.numInputBusChannels;

