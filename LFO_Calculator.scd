/*Mul:
bovengrens – ondergrens / 2
150 – 50 = 100/2 = 50

500 - 200 / 2 =

Add:
ondergrens + mul
50 + 50 = 100*/

(~mul = {
	arg upper, lower;
	upper - lower / 2;
}
~add = {
	arg lower, mul;
	lower + mul;
}
)

~mul.value(300, 200);
~add.value(200, ~mul.value(200, 300));

SinOsc.kr(
		freq: 10,
		mul: 50,
		add: 150
	)