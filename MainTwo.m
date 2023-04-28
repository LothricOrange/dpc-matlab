clc;
clear;
close all;

%% 测试
change = 0;
originData = load('.\dataset\shape\Hearts.txt');
[Arg, ~] = size(originData);
dc = 0.1;
for i = 1 : 50
    originData = load('.\dataset\shape\Hearts.txt');
    evaluation = DPCUtils.DPC(originData, 0.1*i);
    sum = evaluation(1) + evaluation(2) + evaluation(3);
    evArr(i) = sum;
%     if (sum >= max)
%         max = sum;
%         change = i;
%     end
end
[sortEV, indexArr] = sort(evArr, 'descend');
maxN = max(evArr);


%% finish
originData = load('.\dataset\newDataSet\Lineblobs.txt');
evaluation = MyDPC(originData, 3, 5, -1, true);
disp(evaluation);


originData = load('.\dataset\newDataSet\Sticks.txt');
evaluation = MyDPC(originData, 4, 0, 0.2, true);
disp(evaluation);

originData = load('.\dataset\newDataSet\db13.txt');
evaluation = MyDPC(originData, 4, 0, 1.7, true);
disp(evaluation); % TODO
originData = load('.\dataset\newDataSet\db13.txt');
evaluation = MyDPC(originData, 4, 0, 0.6, true);
disp(evaluation); % TODO

originData = load('.\dataset\newDataSet\cmc.txt');
evaluation = MyDPC(originData, 3, -1, 0.2, true);
disp(evaluation);

originData = load('.\dataset\newDataSet\cmc.txt');
evaluation = MyDPC(originData, 3, 2, -1, true);
disp(evaluation);

originData = load('.\dataset\newDataSet\cmc.txt');
evaluation = MyDPC(originData, 3, -1, 0.5, true);
disp(evaluation);


originData = load('.\dataset\newDataSet\circle3.txt');
evaluation = MyDPC(originData, 3, -1, 0.5, true);
disp(evaluation);
originData = load('.\dataset\newDataSet\circle3.txt');
evaluation = MyDPC(originData, 3, -1, 0.8, true);
disp(evaluation);
%% Kaka
originData = load('.\dataset\shape\D31.txt');
evaluation = DPCUtils.DPC(originData, 1.0);
disp(evaluation);

originData = load('.\dataset\shape\a2.txt');
evaluation = DPCUtils.DPC(originData, 1.0);
disp(evaluation);

originData = load('.\dataset\shape\a3.txt');
evaluation = DPCUtils.DPC(originData, 1.0);
disp(evaluation);

originData = load('.\dataset\shape\Aggregation.txt');
evaluation = DPCUtils.DPC(originData, 4.1);
disp(evaluation);

originData = load('.\dataset\shape\Compound.txt');
evaluation = DPCUtils.DPC(originData, 4.6);
disp(evaluation);

originData = load('.\dataset\shape\Hearts.txt');
evaluation = DPCUtils.DPC(originData, 7);
disp(evaluation);


