 function DataSet = simulateDataStruct
% ParticipantNumber = {1:10};

for iP = 1:14
    DataSet.P(iP).Data= simBayesConfNORM; 
end

 DataSet.Spec.Mu = (1/16).*pi;
 DataSet.Spec.binNum = 10;
save([pwd '/DataStructModel1']);
% 
% [X,Y] = (DataSet.Data.Percept, DataSet.Data.Contrast);
% [Z] = DataSet.Data.Confidence
% R = sqrt(X.^2 + Y.^2) + eps;
% Z = sin(R)./R;
% mesh(X,Y,Z)
