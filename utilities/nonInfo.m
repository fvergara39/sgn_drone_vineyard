% Funzione che elimina i dati privi di informazione (corrispondenti a
% valori Inf o Nan)

function clean_values = nonInfo(x,y)

for i=1:size(x,1)
    if abs(y(i))==Inf || abs(x(i))==Inf || isnan(y(i)) || isnan(x(i))
        y(i)=nan;
        x(i)=nan;
    end

end
y(isnan(y)) = [];
x(isnan(x)) = [];
clean_values = [x , y];