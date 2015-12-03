function test
tr = importdata('tr.mat');
net = importdata('TrainData.mat');
y = importdata('Test.mat');
t = importdata('True.mat');
e = gsubtract(t,y);

figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotresponse(t,y)
figure, ploterrcorr(e)
figure, plotconfusion(t,y)
end