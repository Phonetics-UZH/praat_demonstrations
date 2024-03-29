### function_createPulseTrains.praat
# 
# Praat Script for Praat software (www.praat.org)
# Written by Volker Dellwo (volker.dellwo@uzh.ch)
#
# Description: 
# This script creates a variety of pulse trains for 
# for demonstration purposes. 
#
# History: 
# 28.11.2011: created

form pulse train creator
   comment This script creates pulse trains with increasing frequency. 
   comment Set the following values:
   positive freqStep 10; the step size of frequency increase
   positive maxFreq 120; celeing value for frequency. This value has to be a whole number multiple of freqStep or script will breake down.
endform

for iFreq from freqStep to maxFreq
   Create Sound from formula... 'iFreq' Mono 0 1 44100 0
   nSamples = Get number of samples
   setClick = round(nSamples/iFreq)
   counter = setClick
   for iSample to nSamples
      if iSample = counter
         Set value at sample number... iSample 0.9
         counter+=setClick
      endif
   endfor
   iFreq+=9
endfor