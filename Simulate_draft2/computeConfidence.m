function conf = computeConfidence(nTrials,Data, sigma_s, mu_cat1)
%%%% CHECK THIS PLEASE - IS THE Mu-CAT1/2 right??? 
conf = zeros(nTrials, 1);
for i = 1:nTrials  
    
    if Data.ModelType == 0
        
        if Data.Decision(i,1) == 1
           conf(i,1) = (1 / (1 + ((exp(((-2)*(Data.Percept(i, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.SigmaX(i,1))^2)))))));
        else 
           conf(i,1) = (1 / (1 + ((exp(((2)*(Data.Percept(i, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.SigmaX(i,1) )^2)))))));
        end
    else
        posteriorRatio = (normcdf(0, -Data.Percept(i, 1), Data.SigmaX(i,1) ))/(1 - (normcdf(0, -Data.Percept(i, 1), Data.SigmaX(i,1) )));
       
        if Data.Decision(i,1) == 1
           conf(i,1) = (1 / (1 + (posteriorRatio)^-1)); 
        else
           conf(i,1) = (1 / (1 + (posteriorRatio)));
        end
        
%         if conf(i,1) < 0.5 
%              error('Code not functioning as expected')
%         end

    end
end      
end