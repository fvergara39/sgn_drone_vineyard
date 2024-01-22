% Funzione che plotta i LaserScan msgs limitandosi a un angolo visivo dell' intervallo 
% [anglemin, anglemax] appartenente [0,2pi]

function [distance,yd,zd,new_angles,new_ranges] = scans_profile(scanStructs,anglemin,anglemax,start,terminal)

minAngle = scanStructs{1}.AngleMin;
maxAngle = scanStructs{1}.AngleMax;
stepAngle = scanStructs{1}.AngleIncrement;
scanAngles = (minAngle:stepAngle:maxAngle)';

ns = size(scanStructs,1);
% Creazione vettore dei tempi
scanTimes = zeros(ns,1);
for p=1:ns
    if p==1
        scanTimes(1) = scanStructs{1}.ScanTime;
    else
        scanTimes(p) = scanStructs{p}.ScanTime + scanTimes(p-1);
    end
    %scanTimes
end

for struct_num=start:terminal

    scanRanges = scanStructs{struct_num}.Ranges;
    [original_angles, original_ranges] = zero2pi_meas(scanAngles,scanRanges);
    angles = original_angles;
    ranges = original_ranges;
    for p =1:size(original_angles)
        if (original_angles(p)>= anglemin) && (original_angles(p)<= anglemax)
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

    distance = scanTimes*0.5;

    nr = size(new_ranges,1);
    yd = zeros(nr,1);
    zd = zeros(nr,1);

    % conversione coordinate cartesiane degli nr ranges
    for j=1:nr
        yd(j) = new_ranges(j)*sin(new_angles(j));
        zd(j) = new_ranges(j)*cos(new_angles(j));
    end

    dist_s = distance(struct_num,:)*ones(nr,1);

    figure(4)
    grid on
    plot3(yd,dist_s,zd,'o')
    xlabel('y - Width')
    ylabel('x - Distance')
    zlabel('z - Height')

    title('Profilo dei filari - LaserScan - \{L\}')
    hold on
end
hold off
ax = gca;
ax.XDir = 'reverse';