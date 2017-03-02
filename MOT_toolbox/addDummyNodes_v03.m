function [Net_Cost_Mat_dummy, NN_dummy, detectionInds, dummyInds] = addDummyNodes_v03(Net_Cost_Mat, NN, dummyCounts, dummyWeight)

Net_Cost_Mat_dummy = ones(sum(NN)+sum(dummyCounts))*dummyWeight;

detectionInds = [];
dummyInds = [];
count = 0;
for i = 1:length(NN)
    detectionInds = [detectionInds; ones(NN(i),1)*i; zeros(dummyCounts(i),1)];
    dummyInds = [dummyInds; zeros(NN(i),1); ones(dummyCounts(i),1)*i];
    Net_Cost_Mat_dummy(count+1:count+NN(i)+dummyCounts(i),count+1:count+NN(i)+dummyCounts(i)) = NaN;
    count = count + NN(i) + dummyCounts(i);
end
%oldInds = logical(oldInds);

Net_Cost_Mat_dummy(detectionInds>0, detectionInds>0) = Net_Cost_Mat;
% Net_Cost_Mat_dummy(oldInds, ~oldInds) = dummyWeight;
% Net_Cost_Mat_dummy(~oldInds, oldInds) = dummyWeight;
Net_Cost_Mat_dummy(detectionInds==0, detectionInds==0) = Net_Cost_Mat_dummy(detectionInds==0, detectionInds==0);% -0.001;

NN_dummy = NN + dummyCounts;

nodesAdded = ones(size(Net_Cost_Mat_dummy,1),1);
nodesAdded(detectionInds>0) = 0;
end

