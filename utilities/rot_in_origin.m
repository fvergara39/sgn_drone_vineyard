% Funzione che sottopone a rotazione rigida un insieme di punti attorno
% all'origine del frame e una traslazione di questi punti in
% modo da centrarli all'origine 
%
% Rotazione attorno all'asse AX di angolo ANGLE e vettore posizione P 
% del punto da riportare all'origine

function Rt = rot_in_origin(ax , angle, p)

if ax =='x'
    Rt = [    1       0           0       -p(1);
             0  cos(angle)  -sin(angle)   -p(2);
             0  sin(angle)  cos(angle)    -p(3);
             0       0           0           1 ];
elseif ax=='y'
    Rt = [cos(angle)  0   sin(angle)  -p(1); 
             0        1       0       -p(2);
        -sin(angle)   0   cos(angle)  -p(3);
               0      0        0         1 ];
elseif ax=='z'
    Rt = [cos(angle)  -sin(angle)  0      -p(1); 
         sin(angle)   cos(angle)   0      -p(2);
              0           0        1      -p(3); 
              0           0        0         1 ];

else
    disp('Asse non esistente. Scegli tra | x | y | z |')
end