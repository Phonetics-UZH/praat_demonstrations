# create rectangular wave: 
rectangular = Create Sound from formula: "rectangular", 1, 0, 3, 48000, "if col>48000 and col<96000 then 1 else 0 fi"

# create triangular wave: 
select rectangular
triangular = Copy: "triangular"
t=1
for i from 48001 to 96000
	Set value at sample number: 0, i, t
	t-=1/48000
endfor

# convolution
select rectangular 
	plus triangular
	convolution = Convolve: "integral", "zero"
	Rename: "convolution"

# cross-correlation
select rectangular
	plus triangular
	crosscorrelation = Cross-correlate: "integral", "zero"
	Rename: "cross_correlation"

# auto-correlation






