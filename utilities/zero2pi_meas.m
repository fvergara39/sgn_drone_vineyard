
% La funzione ottiene in ingresso un vettore ANGLES di angoli ordinati
% appartenenti all'intervallo [-pi,+pi], a cui sono associate delle
% distanze del vettore RANGES.
% In uscita si ha ORDERED_ANGLES , un array di angoli ordinati appartenenti
% all'intervallo [0,2pi], e le relative distanze dell'array ORDERED_RANGES

function [ordered_angles , ordered_ranges] = zero2pi_meas(angles, ranges)

positive = find(angles>=0);
negative = find(angles<0);

first_pi = angles(positive);
first_ranges = ranges(positive);
neg_pi = angles(negative);
neg_ranges = ranges(negative);

[n,b]=size(neg_pi);
second_pi = zeros(n,b);
second_ranges = zeros(n,b);

for i= 1:n
    second_pi(i)= 2*pi + neg_pi(i);
    second_ranges(i)= neg_ranges(i);
end
second_pi(1) = []; % geometricamente, pi =-pi
second_ranges(1) = [];

ordered_angles = [first_pi ;second_pi];
ordered_ranges = [first_ranges ; second_ranges];

