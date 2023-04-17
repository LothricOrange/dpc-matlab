clc;
clear;
close all;

%% MyDPC(originData, clusterNum, K, dc, isDraw) 参数说明
% clusterNum -- 需要聚类的数目
% K -- k近邻
% dc -- 半径 -- 传的dc > 0时使用高斯核计算局部密度
% isDraw -- 是否画图
originData = load('.\dataset\shape\flame.txt');
evaluation = MyDPC(originData, 2, 11, -1, true);
disp(evaluation);

originData = load('.\dataset\shape\jain.txt');
evaluation = MyDPC(originData, 2, 5, -1, true);
disp(evaluation);

originData = load('.\dataset\uci\iris.txt');
evaluation = MyDPC(originData, 3, 36, -1, true);
disp(evaluation);

originData = load('.\dataset\uci\Wine.txt');
evaluation = MyDPC(originData, 3, 42, -1, true);
disp(evaluation);

originData = load('.\dataset\uci\Wdbc.txt');
evaluation = MyDPC(originData, 2, 16, -1, true);
disp(evaluation);

%% 调参
max = 0;
change = 0;
originData = load('.\dataset\uci\Wdbc.txt');
[Arg, ~] = size(originData);
tmp = Arg / 2;
for i = 2 : Arg - 1
    evaluation = MyDPC(originData, 2, i, -1, false);
    sum = evaluation(1) + evaluation(2) + evaluation(3);
    if (sum > max)
        max = sum;
        change = i;
    end
end