% clusterNum -- 需要聚类的数目
% K -- k近邻
% dc -- 半径
% isDraw -- 是否画图
function [evaluation] = MyDPC(originData, K, dc, isDraw) 
    missTypeData = originData(:, 1:end-1); 
    ndhData = libsvmscale(missTypeData, 0, 1); 
    [row, ~] = size(originData);
    distanceArr = pdist(ndhData);
    distMatrix = squareform(distanceArr);
    ascOrderDistanceArr = sort(distanceArr);
    typeArr = originData(:,end);
    good = unique(typeArr(:));
    [clusterNum,~] = size(good);
    %如果传了dc，局部密度的计算用 高斯核/截断核
    %这里开始测试效率高一些
    if (dc > 0) 
        %dc = DPCUtils.getDeterminateRadius(ascOrderDistanceArr, dc);
        rho = DPCUtils.getGaussianKernel(distMatrix, dc);
        %rho = DPCUtils.getCutOffKernel(distMatrix, dc);
    else
        [rho, wList, RnnList, SnnList, KnnList] = DPCUtils.getLocalDensity2(distMatrix, K);
    end
    %rho = DPCUtils.getGaussianKernel(distMatrix, 0.2);
    %相对距离
    maxDistance = ascOrderDistanceArr(end);
    [~, ordrho] = sort(rho,'descend');  
%     delta(ordrho(1)) = -1.; 
%     nneigh(ordrho(1)) = 0; 

    for i = 2 : row  
       delta(ordrho(i)) = maxDistance;
       for j = 1 : i - 1
         if (distMatrix(ordrho(i), ordrho(j)) < delta(ordrho(i)))  
            delta(ordrho(i)) = distMatrix(ordrho(i), ordrho(j));  
            nneigh(ordrho(i)) = ordrho(j);    
         end  
       end  
    end

    % 找类簇中心    
    delta(ordrho(1)) = max(delta(:));  
    rho = mapminmax(rho, 0, 1);
    delta = mapminmax(delta, 0, 1);

    gamma = zeros(1, row);
    for i = 1 : row 
      gamma(i) = rho(i) * delta(i);
    end  
    
    [~, gamma_order] = sort(gamma, 'descend');

    clusterCenter = gamma_order(1 : clusterNum);

    clusterType = zeros(1, row); % 有些数据集类型是有0类型的。。。
    for i=1 : row  
          clusterType(i) = -1;  
    end  

    [~, NCLUSTER] = size(clusterCenter); % NCLUST <= clusterNum
    for i = 1 : NCLUSTER
        clusterType(clusterCenter(i)) = i;
    end
    
    %clusterType = DPCUtils.doAllocation3(clusterCenter, clusterType, KnnList, SnnList, RnnList, K, row);
    
    %wait = 0;
    
    
    %-----------------------------------------------------------
    if dc <= 0
        clusterType = DPCUtils.doAllocation(wList, clusterType);
    end
%     processedSample = clusterCenter;
%     for i = 1 : row
%         if (clusterType(i) == -1)
%             for j = 1 : row
%                 fatherIndex = indexArr(i, j);
%                 if ismember(fatherIndex, processedSample) == 1
%                     break;
%                 end
%             end
%             clusterType(i) = clusterType(fatherIndex);
%             processedSample = [processedSample,i];
%         end
%     end

%     processedSample = clusterCenter;
%      % 为其他样本染色
%      for i = 1 : NCLUSTER
%            indexForPS = processedSample(i);
%            indexForUnPS= indexArr(indexForPS, 1);
%           clusterType(indexForUnPS) = clusterType(indexForPS);
%           
%      end
        
    
    for i = 1 : row  
      if (clusterType(ordrho(i)) == -1)  
        clusterType(ordrho(i)) = clusterType(nneigh(ordrho(i)));  
      end  
    end

    % 画图
    if isDraw
        F = [ndhData, clusterType'];
        ShowCluster(F);   
        %画中心
        for i = 1 : NCLUSTER
           center = clusterCenter(i);
           scatter(ndhData(center, 1), ndhData(center, 2), 100, 'kh', 'MarkerFaceColor', 'w');
           hold on;
        end
    end

    ami = GetAmi(originData(:,end), clusterType');
    ari = GetAri(originData(:,end), clusterType');
    fmi = GetFmi(originData(:,end), clusterType');
    evaluation = [ami, ari, fmi];
end




