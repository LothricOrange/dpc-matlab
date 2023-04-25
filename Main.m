clc;
clear;
close all;

shapePathAndK = [
".\dataset\shape\a2.txt",1;
".\dataset\shape\a3.txt",1;
".\dataset\shape\Aggregation.txt",1;
".\dataset\shape\Compound.txt",1;
".\dataset\shape\D31.txt",1;
".\dataset\shape\flame.txt",27;
".\dataset\shape\Hearts.txt",22;
".\dataset\shape\R15.txt",1;
".\dataset\shape\seeds_dataset.txt",1;
".\dataset\shape\t4.8k.txt",1;
".\dataset\shape\Twomoons.txt",1;
".\dataset\shape\userKnowledge.txt",1;
];

%% MyDPC(originData, clusterNum, K, dc, isDraw) 参数说明
% clusterNum -- 需要聚类的数目
% K -- k近邻
% dc -- 半径 -- 传的dc > 0时使用高斯核计算局部密度
% isDraw -- 是否画图
originData = load(shapePathAndK(6,1));
K = shapePathAndK(6,2);
evaluation = MyDPC(originData, str2double(K), -1, true);
disp(evaluation);

originData = load('.\dataset\shape\flame.txt');
evaluation = DPCUtils.MyDPC(originData, 27);
disp(evaluation);


originData = load('.\dataset\shape\flame.txt');
evaluation = DPCUtils.DPC(originData, 2.7);
disp(evaluation);

originData = load('.\dataset\shape\jain.txt');
evaluation = DPCUtils.MyDPC(originData, 22);
disp(evaluation);

originData = load('.\dataset\shape\R15.txt');
evaluation =DPCUtils. MyDPC(originData, 17);
disp(evaluation);

originData = load('.\dataset\shape\seeds_dataset.txt');
evaluation = DPCUtils.MyDPC(originData, 7);
disp(evaluation);



originData = load('.\dataset\shape\userKnowledge.txt');
evaluation = DPCUtils.MyDPC(originData, 12);
disp(evaluation);

originData = load('.\dataset\newDataSet\Aggregation.txt');
evaluation = DPCUtils.MyDPC(originData, 11);
disp(evaluation);
%% 流型数据集
%Twomoons
originData = load('.\dataset\shape\Twomoons.txt');
evaluation = DPCUtils.MyDPC(originData, 2);
disp(evaluation);
%ring
originData = load('.\dataset\newDataSet\ring.txt');
evaluation = DPCUtils.MyDPC(originData, 6);
disp(evaluation);
%Compound
originData = load('.\dataset\newDataSet\Compound.txt');
evaluation = DPCUtils.MyDPC(originData, 9);
disp(evaluation);
%cth3
originData = load('.\dataset\newDataSet\cth3.txt');
evaluation = DPCUtils.MyDPC(originData, 19);
disp(evaluation);
% Lineblobs
originData = load('.\dataset\newDataSet\Lineblobs.txt');
evaluation = DPCUtils.MyDPC(originData, 5);
disp(evaluation);
% Pathbased
originData = load('.\dataset\newDataSet\pathbased.txt');
evaluation = DPCUtils.MyDPC(originData, 17);
disp(evaluation);
% Spiral
originData = load('.\dataset\newDataSet\spiral.txt');
evaluation = DPCUtils.MyDPC(originData, 3);
disp(evaluation);
% Jain
originData = load('.\dataset\newDataSet\jain.txt');
evaluation = DPCUtils.MyDPC(originData, 11);
disp(evaluation);
% Sticks
originData = load('.\dataset\newDataSet\Sticks.txt');
evaluation = DPCUtils.MyDPC(originData, 2);
disp(evaluation);
% Db
originData = load('.\dataset\newDataSet\db13.txt');
evaluation = DPCUtils.MyDPC(originData, 13);
disp(evaluation); % TODO
% Cmc
originData = load('.\dataset\newDataSet\cmc.txt');
evaluation = DPCUtils.MyDPC(originData, 2);
disp(evaluation);
% Circle
originData = load('.\dataset\newDataSet\circle3.txt');
evaluation = DPCUtils.MyDPC(originData, 19);
disp(evaluation);

%% uci
originData = load('.\dataset\uci\iris.txt');
evaluation = DPCUtils.MyDPC(originData, 7);
disp(evaluation);

originData = load('.\dataset\uci\Wine.txt');
evaluation = DPCUtils.MyDPC(originData, 32);
disp(evaluation);

originData = load('.\dataset\uci\Wdbc.txt');
evaluation = DPCUtils.MyDPC(originData, 61);
disp(evaluation);

originData = load('.\dataset\uci\seeds_dataset.txt');
evaluation = DPCUtils.MyDPC(originData, 7);
disp(evaluation);



originData = load('.\dataset\uci\Ionosphere.txt');
evaluation = DPCUtils.MyDPC(originData, 32);
disp(evaluation);

originData = load('.\dataset\uci\Libras.txt');
evaluation = DPCUtils.MyDPC(originData, 5);
disp(evaluation);

originData = load('.\dataset\uci\Ecoli.txt');
evaluation = DPCUtils.MyDPC(originData, 20);
disp(evaluation);

originData = load('.\dataset\uci\dermatology.txt');
evaluation = DPCUtils.MyDPC(originData, 7);
disp(evaluation);

originData = load('.\dataset\uci\Segmentation.txt');
evaluation = DPCUtils.MyDPC(originData, 10);
disp(evaluation);


% '.\dataset\uci\Avila.txt'
% '.\dataset\uci\balance-scale.txt'
% '.\dataset\uci\ChlorineConcentration.txt'
% '.\dataset\uci\default of credit card clients.txt'
% '.\dataset\uci\dermatology.txt'
% '.\dataset\uci\drivFace.txt'
% '.\dataset\uci\Epileptic Seizure Recognition.txt'
% '.\dataset\uci\FordA.txt'
% '.\dataset\uci\FordB.txt'
% '.\dataset\uci\Gas Sensor Array Drift.txt'
% '.\dataset\uci\Gas Sensor Array Drift Dataset at Different Concentrations.txt'
% '.\dataset\uci\Internet Advertisements.txt'
% '.\dataset\uci\Ionosphere.txt'
% '.\dataset\uci\iris.txt'
% '.\dataset\uci\Libras.txt'
% '.\dataset\uci\Mice Protein Expression.txt'
% '.\dataset\uci\musk.txt'
% '.\dataset\uci\Online Shoppers Purchasing Intention.txt'
% '.\dataset\uci\parkinsons1.txt'
% '.\dataset\uci\pendigits.txt'
% '.\dataset\uci\pendigits.txt'
% '.\dataset\uci\RingNorm.txt'
% '.\dataset\uci\secom.txt'
% '.\dataset\uci\seeds_dataset.txt'
% '.\dataset\uci\Segmentation.txt'
% '.\dataset\uci\Sensorless_drive_diagnosis.txt'
% '.\dataset\uci\shuttle.txt'
% '.\dataset\uci\UWaveGestureLibraryAll.txt'
% '.\dataset\uci\Wafer.txt'
% '.\dataset\uci\Wdbc.txt'
% '.\dataset\uci\Wine.txt'
%% 调参
%max = 0;
clc;
clear;
close all;

% change = 0;
originData = load('.\dataset\uci\Ecoli.txt');
[Arg, ~] = size(originData);
tmp = Arg / 2;
evArr = zeros(1, Arg);
for i = 2 : Arg - 1
    evaluation = MyDPC(originData, i, -1, false);
    sum = evaluation(1) + evaluation(2) + evaluation(3);
    evArr(i) = sum;
%     if (sum >= max)
%         max = sum;
%         change = i;
%     end
end
[sortEV, indexArr] = sort(evArr, 'descend');
maxN = max(evArr);

%% 调参
%max = 0;
change = 0;
originData = load('.\dataset\newDataSet\Twomoons.txt');
[Arg, ~] = size(originData);
dc = 0.1;
for i = 1 : 100
    evaluation = MyDPC(originData,0, i*dc, false);
    sum = evaluation(1) + evaluation(2) + evaluation(3);
    evArr(i) = sum;
%     if (sum >= max)
%         max = sum;
%         change = i;
%     end
end
[sortEV, indexArr] = sort(evArr, 'descend');
maxN = max(evArr);