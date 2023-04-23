clc;
clear;
close all;

%% MyDPC(originData, clusterNum, K, dc, isDraw) 参数说明
% clusterNum -- 需要聚类的数目
% K -- k近邻
% dc -- 半径 -- 传的dc > 0时使用高斯核计算局部密度
% isDraw -- 是否画图
originData = load('.\dataset\shape\flame.txt');
evaluation = MyDPC(originData, 2, 27, -1, true);
disp(evaluation);

originData = load('.\dataset\shape\flame.txt');
evaluation = MyDPC(originData, 2, 16, -1, true);
disp(evaluation);


originData = load('.\dataset\shape\flame.txt');
evaluation = MyDPC(originData, 2, 11, 2.7, true);
disp(evaluation);

originData = load('.\dataset\shape\jain.txt');
evaluation = MyDPC(originData, 2, 22, -1, true);
disp(evaluation);

originData = load('.\dataset\uci\iris.txt');
evaluation = MyDPC(originData, 3, 12, -1, true);
disp(evaluation);

originData = load('.\dataset\uci\Wine.txt');
evaluation = MyDPC(originData, 3, 45, -1, true);
disp(evaluation);

originData = load('.\dataset\uci\Wdbc.txt');
evaluation = MyDPC(originData, 2, 41, -1, true);
disp(evaluation);

originData = load('.\dataset\newDataSet\LineBlobs.txt');
evaluation = MyDPC(originData, 3, 5, -1, true);
disp(evaluation);

originData = load('.\dataset\newDataSet\Pathbased.txt');
evaluation = MyDPC(originData, 3, 17, -1, true);
disp(evaluation);

originData = load('.\dataset\newDataSet\spiral.txt');
evaluation = MyDPC(originData, 3, 5, -1, true);
disp(evaluation);

originData = load('.\dataset\newDataSet\Aggregation.txt');
evaluation = MyDPC(originData, 7, 34, -1, true);
disp(evaluation);
%% 流型数据集
% Lineblobs
originData = load('.\dataset\newDataSet\Lineblobs.txt');
evaluation = MyDPC(originData, 3, 5, -1, true);
disp(evaluation);
% Pathbased
originData = load('.\dataset\newDataSet\pathbased.txt');
evaluation = MyDPC(originData, 3, 17, -1, true);
disp(evaluation);
% Spiral
originData = load('.\dataset\newDataSet\spiral.txt');
evaluation = MyDPC(originData, 3, 3, -1, true);
disp(evaluation);
% Jain
originData = load('.\dataset\newDataSet\jain.txt');
evaluation = MyDPC(originData, 2, 11, -1, true);
disp(evaluation);
% Sticks
originData = load('.\dataset\newDataSet\Sticks.txt');
evaluation = MyDPC(originData, 4, 2, -1, true);
disp(evaluation);
% Db
originData = load('.\dataset\newDataSet\db13.txt');
evaluation = MyDPC(originData, 4, 13, -1, true);
disp(evaluation); % TODO
% Cmc
originData = load('.\dataset\newDataSet\cmc.txt');
evaluation = MyDPC(originData, 3, 2, -1, true);
disp(evaluation);
% Circle
originData = load('.\dataset\newDataSet\circle3.txt');
evaluation = MyDPC(originData, 3, 19, -1, true);
disp(evaluation);

%% 调参
%max = 0;
change = 0;
originData = load('.\dataset\shape\flame.txt');
[Arg, ~] = size(originData);
tmp = Arg / 2;
evArr = zeros(1, Arg);
for i = 2 : Arg - 1
    evaluation = MyDPC(originData, 2, i, -1, false);
    sum = evaluation(1) + evaluation(2) + evaluation(3);
    evArr(i) = sum;
%     if (sum >= max)
%         max = sum;
%         change = i;
%     end
end
[sortEV, indexArr] = sort(evArr, 'descend');
maxN = max(evArr);