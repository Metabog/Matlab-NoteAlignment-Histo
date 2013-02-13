function [ ] = plotHistograms( pastoGram, futuroGram, plotTitle )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure
subplot(2,1,1);
colormap(jet);
imagesc(pastoGram);
title(plotTitle);


subplot(2,1,2);
colormap(jet);
imagesc(futuroGram);





end

