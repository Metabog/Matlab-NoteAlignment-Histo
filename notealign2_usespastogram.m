%%

%get midi files

perf = midi2nmat('040513_A_01_000_000_A1_007_FIXED.mid');
notation_1 = midi2nmat('1_prelude_prima_fix.mid');
notation_2 = midi2nmat('1_prelude_seconda.mid');

ch1_p = midi2nmat('040513_A_01_000_000_A1_007_P1.mid');
%notation_1 = midi2nmat('BV_TEST_NORMAL.mid');

%separate channels for the performed one.

%%
close all;
%get histograms

notation  = getHistograms(notation_1, 1);
performance = getHistograms(ch1_p, 1);


plotHistograms(notation.pastoGram,notation.futuroGram,'notation');
plotHistograms(performance.pastoGram,performance.futuroGram,'performance');

%%
%now let's do the alignment
%{
For every note in the notation we have the histograms. For every histogram,
subtract it from every other histogram in the performed version and take
the absolute value. This should give the distance between the two, and thus
how similar they are.
%}

% no need to zero pad

m = size(notation.pastoGram,1);
n = size(performance.pastoGram,1);
p = size(performance.histoNB,1);

pGramDiff = [];
fGramDiff = [];


solutions = [];

for i = 1:m
%for each element in notation
    comparisons = [];
    for j = 1:n
    %for each element in performance
     pastoCompare = notation.pastoGram(i,:) - performance.pastoGram(j,:);
     futuroCompare = notation.futuroGram(i,:) - performance.futuroGram(j,:);
     NBCompare = notation.histoNB(i,:) - performance.histoNB(j,:);
     
     pastoCompare = abs(pastoCompare);
     futuroCompare = abs(futuroCompare);
     NBCompare = abs(NBCompare);
     
     comparisons(j) = mean(pastoCompare) + mean(futuroCompare) + mean(NBCompare);
     
     if notation_1(i,4) ~= ch1_p(j,4)
         comparisons(j) = comparisons(j) + 200;
     end
     
    end
    
    [m,index] = min(comparisons);
    
    solutions(i) = index;
    
    
end

%%



%%

%now fil the match matrix with the pastogram data
%

%empty it
M = [];
%FORMAT: NOTATION INDEX, PERF INDEX, NOTATION NOTE, PERF NOTE, NOTATION
%ONSET, PERF ONSET, NOT. VEL, PERF. VEL, NOT. DURATION, PERF. DURATION

for i = 1:length(ch1_p)

   M(i,1) = i;
    M(i,2) = solutions(i);
    
     M(i,3) = notation_1(i,4);
      M(i,4) = ch1_p(solutions(i),4);
      
       M(i,5) = notation_1(i,6);
        M(i,6) =  ch1_p(i,6);
        
        M(i,7) = notation_1(i,5);
        M(i,8) =  ch1_p(i,5);
        
          M(i,9) = notation_1(i,7);
        M(i,10) =  ch1_p(i,7);

end

%%

%%
%%


%%

% messing around with cell arrays

test = {'M', 100,20,30};
test{2,3} = 100;

%% EXPORTS CSV OF THE MATCH
xlswrite('notematch.xls', M, 'notes', 'notes');
%% EXPORTS CSV OF MIDI DATA



xlswrite('notation.xls', notation_1, 'notes', 'notes');
xlswrite('performance.xls', ch1_p, 'notes', 'notes');

%%
