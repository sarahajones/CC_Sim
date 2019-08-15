
XVars.ProduceVar = @(Data) Data.Percept;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials) mean(Data.Confidence(inclTrials));

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.ModelType == 0 & Data.ContrastLevel == 1;
Series(2).FindIncludedTrials = @(Data)   Data.ModelType == 0 & Data.ContrastLevel == 1.5;
Series(3).FindIncludedTrials = @(Data)   Data.ModelType == 0 & Data.ContrastLevel == 2;



PlotStyle.Xaxis(1).Title = 'Percept value(s)';
PlotStyle.Yaxis(1).Title = 'Confidence value(s)';


PlotStyle.Data(1).Name = 'Contrast = 1';
PlotStyle.Data(1).PlotType = 'line';

PlotStyle.Data(2).Name = 'Contrast = 1.5';
PlotStyle.Data(2).PlotType = 'line';

PlotStyle.Data(3).Name = 'Contrast = 2';
PlotStyle.Data(3).PlotType = 'line';

figHandle = mT_plotVariableRelations(DataSet, XVars, YVars, Series, PlotStyle);