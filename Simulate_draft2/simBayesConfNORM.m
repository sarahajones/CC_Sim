function Data = simBayesConfNORM(modelNum)
%% PARAMETER INPUTS 

Data.nTrials = 10000; % number of trials simulated
%properties for circle statistics 
mu_cat1 = (-1/16).*(pi);
mu_cat2 = (1/16).*(pi);

kappa_s = 7;%%kappa (concentration parameter, needs to be convereted for derivations to sigma)
Data.KappaS = kappa_s;
sigma_s = sqrt(1/kappa_s);
prior = 0.5; %assume neutral prior for symmetry of decisions
contrasts = [0.1, 0.2, 0.3, 0.4, 0.8]; %external noise
sigma_X = [0.5, 1, 1.5, 1.75, 5;
    0.5, 1, 1.5, 1.75, 5]/5;
Data.SigmaX_array = sigma_X';
        
    
%% DATA STRUCTURE
%create dataStruct with stimulus properties and trial info

%split an ABBA pattern, here A is 1 Gabor, and   
for iTrial = 1:Data.nTrials
    if iTrial < (Data.nTrials/4)
        Data.BlockType(iTrial, 1) = 0;
        Data.numGabors(iTrial, 1)= 1;
    elseif iTrial > ((3*Data.nTrials)/4)
        Data.BlockType(iTrial, 1) = 0;
        Data.numGabors(iTrial, 1) = 1;
    else
        Data.BlockType(iTrial, 1) = 1;
        Data.numGabors(iTrial, 1) = 2;
    end


end

Data.ModelFitOptions = [1, 2,3, 4];

Data.ModelFit = Data.ModelFitOptions(modelNum);
%set two model types, 0 is Bayes, 1 is Alt. 
display(Data.ModelFit)

for iTrial = 1:Data.nTrials
if Data.ModelFit == 1
    if Data.numGabors(iTrial,1) == 2
        Data.ModelType(iTrial,1) = 0; %normative for 2 gabors
    else
        Data.ModelType(iTrial,1) = 1; %alternative for 1 gabor
    end
    
elseif Data.ModelFit == 2
    Data.ModelType(iTrial,1) = 0; %always normative
    
elseif Data.ModelFit == 3
     if Data.numGabors(iTrial,1) == 2
        Data.ModelType(iTrial,1) = 1; %alternative for 2 gabors
    else
        Data.ModelType(iTrial,1) = 0; %normative for one
     end
     
elseif Data.ModelFit == 4
    Data.ModelType(iTrial,1) = 1; %always alternative 
    
end
end

%label four potential model fits within data struct
if Data.ModelFit ==1
 Data.model  = 'normativeGenerative'; %easy being Rule, hard being BAyes
elseif Data.ModelFit == 2
 Data.model =  'normativeGenerativeAlways'; %always BAyes
elseif Data.ModelFit == 3 
 Data.model = 'alternativeGenerative' ; %easy as BAyes, hard being rule
elseif Data.ModelFit == 4
 Data.model = 'alternativeGenerativeAlways';%always rule based
end

%% ORIENTATION STIMULUS VALUES PER CATEGORY
%set two target categories randomly across nTrials, indepenent of model
%type
Data.Target =  logical(randi([0 1], Data.nTrials, 1)); %the category that should be targetted (correct cat) 0 = cat 1, 1 = cat 2

Data.Orientation = produceOrientations(Data.nTrials, mu_cat1, mu_cat2, kappa_s, Data);

%check on orientations
%figure
%hist (Data.Orientation, 50)

%% NOISE TO GAIN MEASURE X (PERCEPT)
%apply noise to the orientation to gain percept value
%should this be adjusted for noncardinal orientations (Adler & Ma
%paper)??? DO THIS LATER 


Data.ContrastLevel = zeros(Data.nTrials,1);

for iTrial = 1:Data.nTrials
    indexofInterest = randperm(5,1);
    
    Data.ContrastLevel(iTrial,1) = contrasts(indexofInterest);
    if Data.numGabors == 1
       Data.SigmaX(iTrial,1) = sigma_X(1, indexofInterest);
    else
       Data.SigmaX(iTrial,1) = sigma_X(2, indexofInterest);
    end
end

 Data.Percept = producePercept(Data.nTrials, Data);


% If any percepts are outside the range [-pi pi] then move them back in (any
% grating angle can be mapped into this range)
% Data.Percept = vS_mapBackInRange(Data.Percept, -pi, pi);
% Joshua: Commenting out. We should just avoid using regions outside -pi and pi
% because we are using the Gaussian model, rather than mapping back in range.

% check on percepts
%figure
%hist(Data.Percept, 50)

%% COMPUTE DECISION / RESPONSE
%BASED ON FULL LOGLIKLIHOOD RATIO 
%But simple rule amounts to the same thing as:
%the categories are symmetrical and prior is 0.5.


Data.Decision = giveResp(Data.nTrials, Data, mu_cat2, mu_cat1, prior);

%check percentage correct

for i = 1:Data.nTrials
    if Data.Target(i,1) == Data.Decision(i,1)
        Data.Correct(i,1) = 1;
    else
        Data.Correct(i,1) = 0;
    end    
end  

% check on decision accuracy
% sum(Data.Correct, 'all')

%% CONFIDENCE
%calculate confidence value for each trail based on model type and decision
%made by the observer based on their percept. 

Data.Confidence = computeConfidence(Data.nTrials, Data,  sigma_s, mu_cat1);

%figure 
%hist(Data.Confidence([Data.ModelType]==0),10)
%figure 
%hist(Data.Confidence([Data.ModelType]==1),10)

mean(Data.Confidence([Data.ModelType]==0))
mean(Data.Confidence([Data.ModelType]==1))
%% prep DATA.STRUCT for binning
Data.numBins = 10;
Data.quantileSize = 1 / Data.numBins;
Data.pDivisions = 0 : Data. quantileSize : 1;

breaks = quantile(Data.Confidence, Data.pDivisions);
Data.binnedConfidence = discretize(Data.Confidence, breaks);

Data.breaks = breaks;
Data.breaks(1) = [];
Data.breaks(end) = [];
    
end