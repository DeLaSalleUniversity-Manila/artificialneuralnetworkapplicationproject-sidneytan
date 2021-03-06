% Solve an Autoregression Time-Series Problem with a NAR Neural Network
% Script generated by Neural Time Series app
% Created Thu Dec 03 17:27:13 SGT 2015
%
% This script assumes this variable is defined:
%
%   inputs - feedback time series.
close all;clear;clc;

inputs = importfile('PLDT.xls');
inputs = inputs.data';

T = tonndata(inputs,true,false);

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. NTSTOOL falls back to this in low memory situations.
trainFcn = 'trainscg';  % Scaled Conjugate Gradient

% Create a Nonlinear Autoregressive Network
feedbackDelays = 1:2;
hiddenLayerSize = 2;
net = narnet(feedbackDelays,hiddenLayerSize,'open',trainFcn);

% Prepare the Data for Training and Simulation
% The function PREPARETS prepares timeseries data for a particular network,
% shifting time by the minimum amount to fill input states and layer states.
% Using PREPARETS allows you to keep your original time series data unchanged, while
% easily customizing it for networks with differing numbers of delays, with
% open loop or closed loop feedback modes.
[x,xi,ai,t] = preparets(net,{},{},T);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 65/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 20/100;


% Train the Network
[net,tr] = train(net,x,t,xi,ai);

% Test the Network
y = net(x,xi,ai);
e = gsubtract(t,y);
performance = perform(net,t,y)

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotresponse(t,y)
figure, ploterrcorr(e)
figure, plotinerrcorr(x,e)
figure, plotconfusion(t,y)


