form Create sawtooth...
	real fo 130
	positive nHarmonics 100
	real jitter_(in_%) 20
endform

harmonic=fo
for i to nHarmonics

	if i=1
		Create Sound from formula: "complex_'fo'_'jitter'", 1, 0, 1, 44100, "sin(2*pi*harmonic*x)"
	else
		# add jitter:
		jitterDegree = jitter/(nHarmonics-1)*i
		varco=harmonic*(jitterDegree*0.01)
		deviation=randomInteger(varco*-1, varco)
		# create harmonic
		Formula: "self+1/'i'*sin(2*pi*(harmonic+deviation)*x)"
	endif

	harmonic+=fo

endfor

Scale intensity: 70