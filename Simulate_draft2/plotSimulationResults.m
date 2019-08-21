function plotSimulationResults(DataSet)




XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials) mean(Data.binnedConfidence(inclTrials));

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.numGabors == 1 & Data.ContrastLevel == 0.1;
Series(2).FindIncludedTrials = @(Data)   Data.numGabors == 2 & Data.ContrastLevel == 0.1;
Series(3).FindIncludedTrials = @(Data)   Data.numGabors == 1 & Data.ContrastLevel == 0.2;
Series(4).FindIncludedTrials = @(Data)   Data.numGabors == 2 & Data.ContrastLevel == 0.2;
Series(5).FindIncludedTrials = @(Data)   Data.numGabors == 1 & Data.ContrastLevel == 0.3;
Series(6).FindIncludedTrials = @(Data)   Data.numGabors == 2 & Data.ContrastLevel == 0.3;
Series(7).FindIncludedTrials = @(Data)   Data.numGabors == 1 & Data.ContrastLevel == 0.4;
Series(8).FindIncludedTrials = @(Data)   Data.numGabors == 2 & Data.ContrastLevel == 0.4;
Series(9).FindIncludedTrials = @(Data)   Data.numGabors == 1 & Data.ContrastLevel == 0.8;
Series(10).FindIncludedTrials = @(Data)   Data.numGabors == 2 & Data.ContrastLevel == 0.8;


PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Average confidence value(s)';


PlotStyle.Data(1).Name = '1 Gabor';
PlotStyle.Data(1).PlotType = 'scatter';
PlotStyle.Data(2).Name = '2 Gabors';
PlotStyle.Data(2).PlotType = 'scatter';
PlotStyle.Data(3).Name = '';
PlotStyle.Data(3).PlotType = 'scatter';
PlotStyle.Data(4).Name = '';
PlotStyle.Data(4).PlotType = 'scatter';
PlotStyle.Data(5).Name = '';
PlotStyle.Data(5).PlotType = 'scatter';
PlotStyle.Data(6).Name = '';
PlotStyle.Data(6).PlotType = 'scatter';
PlotStyle.Data(7).Name = '';
PlotStyle.Data(7).PlotType = 'scatter';
PlotStyle.Data(8).Name = '';
PlotStyle.Data(8).PlotType = 'scatter';
PlotStyle.Data(9).Name = '';
PlotStyle.Data(9).PlotType = 'scatter';
PlotStyle.Data(10).Name = '';
PlotStyle.Data(10).PlotType = 'scatter';

for i = 1 : 2 : 10
    PlotStyle.Data(i).Colour = mT_pickColour(1);
end


for i = 2 : 2 : 10
    PlotStyle.Data(i).Colour = mT_pickColour(2);
end

figHandle = mT_plotVariableRelations(DataSet, XVars, YVars, Series, PlotStyle);





YVars.ProduceVar = @(Data, inclTrials) mean(Data.SimConf(inclTrials));

for i = 1 : 10
    PlotStyle.Data(i).PlotType = 'errorShading';
end

figHandle = mT_plotVariableRelations(DataSet, XVars, YVars, Series, PlotStyle, figHandle);

