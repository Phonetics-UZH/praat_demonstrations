#                                                                       
#       Praat Script: CREATE SINE WAVE                                                  
#                                                                         
#       This script creates sine waves according to the specifications    
#       of the user and prints the number of cycles either with or without 
#       garnish to the 'Praat picture' window in a colour of your choice
#
#                                     written by Volki                 
#

### Create user interface window ##########################################

form sine wave generator
   comment Please specify your name:
      text name sine-wave
   comment ------------------------------------------------------------------------------------   
      real frequency 200
      real amplitude 1
      real phase 0
   comment ------------------------------------------------------------------------------------
      positive duration 1
      positive sample_rate 22050
      optionmenu quantisation_rate: 1
         option 16 bit
         option 12 bit
         option  8 bit
         option  4 bit
         option  2 bit
         option  1 bit
   comment ------------------------------------------------------------------------------------
      positive number_of_cycles 5
      boolean garnish 1
      boolean headline 1
      optionmenu colour_of_waveform: 3
         option Black
         option White
         option Red
         option Green
         option Blue
         option Yellow
         option Olive
         option Grey
   comment ------------------------------------------------------------------------------------
   comment Where do you want to save your picture output?
      text path C:\Dokumente und Einstellungen\Flok\Desktop\SinePictures
endform

### Create values for sine wave in matrix and transfer it to waveform ########################
numberOfColumns = sample_rate * duration
phaseInRad = phase * 2 * pi / 360
deltaX = 1/sample_rate
firstSample = 0
Create Matrix... 'name$' 0 1 numberOfColumns deltaX firstSample 1 1 1 1 1 amplitude*sin(2*pi*frequency*x+phaseInRad)
To Sound (slice)... 1

### Change quantisation level of sine wave ###############################################################

if quantisation_rate = 1
   bitRate$ = "16bit"
elsif quantisation_rate = 2
   newBitRate = 2048
   bitRate$ = "12bit"
   call changeBitRate
elsif quantisation_rate = 3
   newBitRate = 128
   bitRate$ = "8bit"
   call changeBitRate
elsif quantisation_rate = 4
   newBitRate = 8
   bitRate$ = "4bit"
   call changeBitRate
elsif quantisation_rate = 5
   newBitRate = 2
   bitRate$ = "2bit"
   call changeBitRate
elsif quantisation_rate = 6
   newBitRate = 1
   bitRate$ = "1bit"
   call changeBitRate
endif

procedure changeBitRate
select Sound 'name$'
numberOfSamples = Get number of samples
for run to numberOfSamples
x = Get value at index... 'run'
x = floor(x*newBitRate)/newBitRate
Set value at index... 'run' 'x'
endfor
endproc

################# Graphical output of the waveform ########################################################

Erase all
Line width... 1

# Print headline:
if headline = 1
   Font size... 24
   Maroon
   Viewport... 0 6 0.3 0.8
   Viewport text... Centre Half 0 Sine wave of 'frequency' Hz, 'amplitude' mV, 'phase'°
endif

# Print waveform:
select Sound 'name$'
Viewport... 0.3 6 0.5 4
Font size... 14
'colour_of_waveform$'
Draw... 0 number_of_cycles/frequency -1 1 'garnish'

# Print spectrum:
To Spectrum (fft)
Viewport... 0.3 6 4 8
Blue
Draw... 0 frequency*10 10 90 1 

# Print sampling rate and quantisation:
Black
Font size... 18
Viewport... 1 4 8.5 9 
Viewport text... Centre Half 0 Sampling rate:
Font size... 14
Viewport... 1 4 9 9.5 
Viewport text... Centre Top 0 'sample_rate' samp./sec.
Font size... 18
Viewport... 4 6 8.5 9 
Viewport text... Centre Half 0 Quantisation:
Font size... 14
Viewport... 4 6 9 9.5  
Viewport text... Centre Top 0 'bitRate$'

# Print name
Font size... 16
Viewport... 5 6 0 0.5
Viewport text... Right Top 0 'name$'

################# Organise list of objects ########################################################################

select Matrix 'name$'
Remove
select Sound 'name$'
Rename... 'name$''bitRate$'
select Spectrum 'name$'
Rename... 'name$''bitRate$'

### Save graphical output in file ##########################################################################

Viewport... 0 7 0 10
Write to Windows metafile... 'path$'\'name$'_'bitRate$'_'sample_rate'samp_'frequency'Hz_'amplitude'mV_'phase'°.emf
