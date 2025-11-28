close all; clc; clear;
%%
% Define import options to ensure the header is read correctly
file = 'M:\cleanroom\icp_metal\2025_09_26_backside_polybor_etch\Local Run_0003.dat';
opts = detectImportOptions(file,'Delimiter','\t','FileType','text');
% Override the variable names and types
opts.VariableNames  = {'RunTime','F_7037AV','Av_Si_288','Av_SiF_440','Av_SIF_777'};
opts.VariableTypes  = {'double','double','double','double','double'};
T = readtable(file, opts);

% Extract columns
t     = T.RunTime;
f7037 = T.F_7037AV;
si288 = T.Av_Si_288;
sif440= T.Av_SiF_440;
sif777= T.Av_SIF_777;

% Create a new figure (necessary in R2025a/b for the plot to appear:contentReference[oaicite:1]{index=1})
fig = figure('Name','ICP Metal Run 02','NumberTitle','off','Visible','on');

% Plot all signals
plot(t, f7037,'-', ...
     t, si288,'-', ...
     t, sif440,'-', ...
     t, sif777,'-');
grid on;
xlabel('Run Time [s]');
ylabel('Signal Intensity (arb. units)');
title('ICP Metal Run 02');
legend({'F\_7037AV','Av\_Si\_288','Av\_SiF\_440','Av\_SIF\_777'},'Location','best');

% Force graphics update (helps if window remains blank)
drawnow;
