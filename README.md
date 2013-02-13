Matlab-NoteAlignment-Histo
==========================

Histogram based midi to score alignment.
Uses the Matlab MIDI TOOLBOX.

Expresses the notes in terms of histograms (pitch class profiles) of past and previous notes, and also their local neighbourhood. Then it searches for notes in the performed input MIDI file that are most similar to their corresponding notes in the notation version, and picks the best one. The comparison is just done with a basic mean of the histogram and euclidean distance.

Work in progress.
