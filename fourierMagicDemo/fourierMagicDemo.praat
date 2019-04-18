sound = Read from file: "English.wav"
name$ = selected$("Sound")
sf = Get sampling frequency

# show ft of input sound: 
ft = To Spectrum: 1
ft_m = To Matrix
ft_s = To Sound
Override sampling frequency: sf
Rename: "ft_"+name$

select ft
plus ft_m
Remove

select ft_s
Edit
editor: ft_s
	Spectrogram settings: 0, sf/2, 0.04, 70
endeditor

exit

inv_fft = To Spectrum: 1
inv_fft_m = To Matrix
inv_fft_s = To Sound
Override sampling frequency: 16000
Scale intensity: 70
Edit

