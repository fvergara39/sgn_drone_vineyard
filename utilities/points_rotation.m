%Sottopone a rototraslazione rigida Rt, tutti i punti contenuti 
% nella matrice P 4xn
function P_primo = points_rotation (Rt,P)
n = size(P,2);
P_primo = zeros(4,n);

for i=1:n
    P_primo(:,i) = Rt*P(:,i);
end

    