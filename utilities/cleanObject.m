%Elimina i dati relativi a un'istantanea quando almeno una coordinata è Nan
%o quando i dati sono outliers
% la matrice è composta [x1 , y1, x2, y2]
function [cleanData, values] = cleanObject(A, values)

[row, col] = size(A);
cleanData =A;
I = find(isoutlier(values(:,2)));

for i=1:row
    for j=1:col
        if isnan(cleanData(i,j)) || ismember(i,I)
            cleanData(i,:)= nan(1,col);
        end
    end
end

idx = find(isnan(cleanData(:,1)));
notidx = find(~isnan(cleanData(:,1)));
cleanData(idx,:) =[];
values = values(notidx,:);