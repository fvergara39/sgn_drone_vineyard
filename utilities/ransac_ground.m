
% Funzione che fitta con una retta, i dati di DATA riconosciuti come inliers 
% entro la MAXDISTANCE 

function [m,q,x, outlierIdx] = ransac_ground(sampleSize, maxDistance,data)

fitLineFcn = @(data) polyfit(data(:,1),data(:,2),1); % fit function using polyfit
evalLineFcn = @(model, data) sum((data(:, 2) - polyval(model, data(:,1))).^2,2); % distance evaluation function
[modelRANSAC, inlierIdx] = ransac(data,fitLineFcn,evalLineFcn, sampleSize,maxDistance);
outlierIdx = ~inlierIdx;

% Refit degli inliers con polyfit
modelInliers = polyfit(data(inlierIdx,1),data(inlierIdx,2),1);
%Display della fitline robusta agli outliers
inlierPts = data(inlierIdx,:);
outlierPts = data(outlierIdx,:);
x = [min(inlierPts(:,1)) max(inlierPts(:,1))];
y = modelInliers(1)*x + modelInliers(2); %[x,y] due punti per i quali passa la retta di ransac

m = modelInliers(1);
q = modelInliers(2);