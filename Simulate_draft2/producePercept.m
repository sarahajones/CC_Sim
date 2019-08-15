function [percept] = producePercept(nTrials,Data)


percept = zeros(nTrials, 1); 

for i = 1:nTrials
   
    noise = randn(1, 1)*(Data.ContrastLevel(i,1)); %computes norm dist of noise
    percept(i,1) = Data.Orientation(i) + noise;

end



end 