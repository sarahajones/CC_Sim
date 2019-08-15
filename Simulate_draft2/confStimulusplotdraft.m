
XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials) mean(Data.Confidence(inclTrials));

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.ModelType == 1;
Series(2).FindIncludedTrials = @(Data)   Data.ModelType == 0;



PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Average confidence value(s)';


PlotStyle.Data(1).Name = 'Alternative Bayesian';
PlotStyle.Data(1).PlotType = 'scatter';

PlotStyle.Data(2).Name = 'Normative Bayesian';
PlotStyle.Data(2).PlotType = 'scatter';

figHandle = mT_plotVariableRelations(DataSet, XVars, YVars, Series, PlotStyle);