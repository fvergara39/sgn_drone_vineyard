% Funzione che plotta i LaserScan msgs limitandosi a un angolo visivo dell'
% intervallo [anglemin, anglemax] appartenente [0,2pi] e plottando per
% DRAWPLOT = 1 , i dati della struttura numero STRUCT_NUM , in 2D

function [angles , ranges, xd, yd] = scans_profile2D(scanStructs, anglemin,anglemax, struct_num, drawPlot)

scanAngles = (scanStructs{struct_num}.AngleMin:scanStructs{struct_num}.AngleIncrement:scanStructs{struct_num}.AngleMax)';
scanRanges = scanStructs{struct_num}.Ranges;
[original_a, original_r] = zero2pi_meas(scanAngles,scanRanges);

angles = original_a;
ranges = original_r;

for p =1:size(original_a)
    if original_a(p)>=anglemin && original_a(p)<= anglemax
        %disp('No changes');
    else
        %disp('Changes');
        angles(p)= nan;
        ranges(p)= nan;
    end
end

cleanValues = nonInfo(angles,ranges);
new_angles = cleanValues(:,1);
new_ranges = cleanValues(:,2);

nr = size(new_ranges,1);
xd = zeros(nr,1);
yd = zeros(nr,1);

% conversione coordinate cartesiane degli nr ranges
for j=1:nr
    yd(j) = new_ranges(j)*cos(new_angles(j));
    xd(j) = new_ranges(j)*sin(new_angles(j));
end
if drawPlot==1
    figure(5)
    grid on
    plot(xd,yd,'o')
    xlabel('y - Width')
    ylabel('x - Distance')
    title('Profilo dei filari - ScanStruct n° ' ,struct_num)
    hold on
end

ax = gca;
ax.XDir = 'reverse';
