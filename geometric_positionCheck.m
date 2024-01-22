addpath('utilities\')
addpath('data\')
load scanData.mat

% Definizione variabili utili
if geomMethod == 1
    ns = size(scanStructs,1);
%     start_s = 185;
%     end_s = 400;
%     start_s = 236;
%     end_s = 260;

    correction = zeros(end_s-start_s+1, 2);
    correction(:,1) = start_s:1:end_s;

    error = zeros(end_s-start_s+1, 2);
    error(:,1) = start_s:1:end_s;

    Right= zeros(end_s-start_s+1, 3);
    Right(:,1) = start_s:1:end_s;

    Left= zeros(end_s-start_s+1, 3);
    Left(:,1) = start_s:1:end_s;

    des_y = 0; % il drone deve rimanere centrale ai filari

    noInfo = zeros(ns,1);
    %
    for struct_num= start_s:end_s
        [~ , ~, yd, zd] = scans_profile2D(scanStructs, 3/4*pi,5/4*pi, struct_num, drawPlot);
        %ylim([-6,-1])
        % Preprocessing
        %scans = nonInfo(xs,ys);
        scans = [yd,zd];

        % Retta del piano di fondo.
        sampleSize = 5; % number of scans to sample per trial
        maxDistance = 0.2; % max allowable distance for inliers
        [m, q , y , outlierIdx] = ransac_ground(sampleSize, maxDistance,scans);

        % Equazione della retta
        %     m = (y(2)-y(1))/(x(2)-x(1));
        %     q = -m*x(1)+y(1);
        Y = y(1):0.1:y(2); % valori delle ascisse da x(1) e x(2).
        Z = m*Y +q; % ground line

        % Rototraslazione dei dati per portare il terreno in linea con
        % l'orizzonte e centrato in (0,0)
        y0 = 0; % coordinate iniziali del punto centrale del terreno
        z0 =  q;

        Rt = rot_in_origin('z',-atan(m), [y0 ; z0; 0]);
        Points = [yd, zd, zeros(size(yd)) , ones(size(yd))]'; % coords omogenee
        Points_primo = points_rotation (Rt,Points); % rototraslazione punti

        Lines = [Y', Z', zeros(size(Y')), ones(size(Y'))]'; % coords omogenee
        Lines_primo = points_rotation (Rt,Lines); % rototraslazione terreno


        % Visualizzazione della rototraslazione
        figure(5)
        if drawPlot == 0
            grid on
            ylim([-0.5,4])
        else
            plot(Y,Z,'g')
        end
        hold on
        plot(Lines_primo(1,:),Lines_primo(2,:),'-b')
        %plot(Points_primo(1,:),Points_primo(2,:),'ob', 'LineWidth',0.5)
        
        % Selezione dei punti
        y_out = Points_primo(1,outlierIdx);
        z_out = Points_primo(2,outlierIdx);
        roiIdx = find(z_out>0 & abs(y_out)<3);
        if ~isempty(roiIdx)
            points_roi = [y_out(roiIdx); z_out(roiIdx)];
            y_roi = points_roi(1,:);
            z_roi = points_roi(2,:);


            % Visualizzazione dei punti di interesse già rototraslati
            plot(y_roi,z_roi,'or')
            if drawPlot == 1
                legend('scanStruct','Retta del piano di fondo','Retta rototraslata','Posizioni stimate dei filari')
            else
                legend('Retta rototraslata','Posizioni stimate dei filari')
            end

            % Distinguo filare a sinistra e a destra
            firstIdx = find(y_roi<0);
            secondIdx = find(y_roi>0);
            first_group = points_roi(1:2,firstIdx);
            second_group = points_roi(1:2,secondIdx);

            % Coordinate dei filari
            if ~(isempty(first_group) || isempty(second_group))
                first_y = mean(first_group(1,:));  % eq. della retta del primo filare : y = first_y
                second_y = mean(second_group(1,:));  % eq. della retta del primo filare : y = second_y

                first_z = max(first_group(2,:)); % altezza del filare a sinistra : z = first_z
                second_z = max(second_group(2,:)); % altezza del filare a destra : z = second_z

                % Aggiorno con le coordinate dello scanStruct corrente
                Left(struct_num-start_s+1,2:3) = [first_y , first_z];
                Right(struct_num-start_s+1,2:3) = [second_y , second_z];
                error(struct_num-start_s+1,2) = des_y - (second_y + first_y)/2 ;
                % se e > 0 --> drone troppo a sinistra
                % se e < 0 --> drone troppo a destra
                correction(struct_num-start_s+1,2) = - error(struct_num-start_s+1,2);
                % se u > 0 --> azione correttrice verso sinistra
                % se u < 0 --> azione correttrice verso destra
            else
                disp(['Acquisizione poco informativa : {', num2str(struct_num),'}'])
                Left(struct_num-start_s+1,2:3) = [nan, nan];
                Right(struct_num-start_s+1,2:3) = [nan, nan];
                correction(struct_num-start_s+1,2) =  nan;
                error(struct_num-start_s+1,2) =  nan;
                noInfo(struct_num) = struct_num;
            end

        else
            disp(['Acquisizione non informativa : {', num2str(struct_num),'}'])
            Left(struct_num-start_s+1,2:3) = [nan, nan];
            Right(struct_num-start_s+1,2:3) = [nan, nan];
            correction(struct_num-start_s+1,2) =  nan;
            error(struct_num-start_s+1,2) =  nan;
            noInfo(struct_num) = struct_num;
        end
    end
    title('Rototraslazione del profilo del vigneto e punti di interesse')
    hold off
    %%
    % Risultati dell'analisi dei dati in {D}
    Coord = [Left , Right(:,2:3)];
    % % Processing dei risultati in {D}
    [cleanCoord, cleanCorrection] = cleanObject(Coord, correction);

    % Valutazione dell'algoritmo
    assesment_geom = noInfo(noInfo ~=0);
end
