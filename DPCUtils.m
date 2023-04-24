classdef DPCUtils
    methods(Static)
        %% 局部密度
        function [rho, wList] = getLocalDensity(distMatrix, K)
            [row,~]=size(distMatrix);
            KnnList = zeros(row, K); %存index
            sortDist = zeros(row, row);

            for i = 1 : row
                [sortDist(i, :),indexArr] = sort(distMatrix(i, :));
                for j = 1 : K  
                    KnnList(i, j) = indexArr(j + 1);
                end
            end
 
            SnnList = zeros(row, row);
            wList = zeros(row, row);
            for i = 1 : row - 1
                for j = i + 1 : row
                    tmpList = intersect(KnnList(i, :),KnnList(j, :));
                    SnnList(i,j) = length(tmpList);
                    tmp = (SnnList(i,j) / K) - (distMatrix(i,j) * distMatrix(i,j));
                    wList(i,j) = exp(tmp);
                end
            end
            wList = wList + wList'; %得到对称矩阵
            RnnList = zeros(1, row);
            
            for i = 1 : row
                for j = 1 : row
%                     if (i == j) 
%                         continue;
%                     end
                    if (ismember(i, KnnList(j,:)))
                        RnnList(i) = RnnList(i) + 1;
                    end
                end
            end
            
            zList = zeros(row, row);
            for i = 1 : row
                for j = 1 : row
                    if (i == j) 
                         continue;
                    end
                     if (ismember(j, KnnList(i,:)))
                         zList(i, j) = exp(-distMatrix(i, j)*distMatrix(i, j));
                     else
                         tmp = exp(-distMatrix(i, j));
                         zList(i, j) = tmp / (tmp + 1);
                     end
                end
            end
            rho =  zeros(1, row);
            
            
            
            aveList = zeros(1, row);
            for i = 1 : row
                tmp = 0;
                for j = K + 2 : row
                    tmp = tmp + sortDist(i,j);
                end
                aveList(i) = tmp / (row - K);
            end

            rho =  zeros(1, row);
            for i = 1 : row
                sum = 0;
                for j = 1 : row
                    if (i == j) 
                        continue;
                    end
%                     if (sortDist(i, K + 1) >= distMatrix(i, j))
%                         sum = wList(i, j) + sum;
%                     
%                         
%                     end
%                     if (aveList(i) >= distMatrix(i, j))
%                             tmp = distMatrix(i, j) / (j - K);
%                             sum = exp(- tmp * tmp) + sum;
%                     end
                    num1 = sortDist(i, K + 1) - distMatrix(i, j);
                    num2 = aveList(i) - distMatrix(i, j);
                    if (num1 > 0)
                        sum = wList(i, j) + sum;
                    end
                    if (num2 > 0)
                        tmp = distMatrix(i, j) / aveList(i);
                        sum = exp(- tmp * tmp) + sum;
                    end
                end
                rho(i) = sum;
            end
%             rho =  zeros(1, row);
%             for i = 1 : row 
%                for j = 1 : row  
%                    if (i == j) 
%                        continue
%                    end
%                   tmp = distMatrix(i,j) / aveList(i);
%                   augend = exp(-tmp * tmp);
%                   rho(i) = rho(i) + augend;   
%                end  
%             end
            
            a = 1;
        end
        
        
        %% 高斯核
        function [rho] = getGaussianKernel(distMatrix, dc)
            [row,~] = size(distMatrix);
            rho =  zeros(1, row);
            for i = 1 : row 
               for j = 1 : row  
                   if (i == j) 
                       continue
                   end
                  tmp = distMatrix(i,j) / dc;
                  augend = exp(-tmp * tmp);
                  rho(i) = rho(i) + augend;   
               end  
            end
        end
        
        %% 截断核
        function [rho] = getCutOffKernel(distMatrix, dc)
            [row,~] = size(distMatrix);
            rho =  zeros(1, row);
            for i=1 : row - 1  
                for j = i + 1 : row  
                    if (distMatrix(i,j) < dc)  
                        rho(i) = rho(i) + 1.;  
                        rho(j) = rho(j) + 1.;  
                    end  
                end  
            end 
        end
        
        %% 取得半径
        function [dc]=getDeterminateRadius(ascOrderDistanceArr, dc)
            [~,len] = size(ascOrderDistanceArr);
            percent = dc / 100;  %dc的范围为0~5
            index = round(len * percent);               
            dc = ascOrderDistanceArr(index);
            if (dc < 0.00000000001)
                for i = 1 : len
                    if (ascOrderDistanceArr(1) ~= 0) 
                        dc = ascOrderDistanceArr(i);
                        break;
                    end
                end
            end
        end
        %% 分配策略
        function [clusterType] = doAllocation(wList, clusterType)
            wCloneList = wList;
            row = size(clusterType, 2);
            while 1
                Sim = wCloneList;
                c=find(clusterType>0);
                d=1:row;
                d=setdiff(d,c);
                Sim(:,d)=zeros(row,size(d,2));
                if max(max(Sim))==0
                    break
                end
                while 1
                    if max(max(Sim))==0
                        break
                    end
                    [a,b]=find(Sim==max(max(Sim)));
                    if clusterType(a(1))<0
                        clusterType(a(1))=clusterType(b(1));
                        wCloneList(a(1),:)=zeros(1,row);
                        break
                    else
                        wCloneList(a(1),b(1))=0;
                        Sim(a(1),b(1))=0;
                    end
                end
                if min(clusterType)==1  %判断所有点是否都分配完成
                    break
                end
                if max(max(wCloneList))==0
                    break
                end
            end
        end
        %% TODO
        function [clusterType] = doAllocation2(wList, clusterType)
            row = size(clusterType, 2);
            indexArr = zeros(row, row);
            wListSortArr = zeros(row, row);
            for i = 1 : row
                [wListSortArr(i, :), indexArr(i, :)] = sort(wList(i, :), 'descend');
            end
            
            %map = containers.Map;
            map = java.util.Hashtable;
            for i = 1 : row
                if (clusterType(i) ~= -1)
                    map.put(i, indexArr(i, :));
                end
            end

            while (map.size() ~= row)
                keySet = map.keys;
                maxSim = 0;
                while (keySet.hasNext)
                    key = keySet.nextElement;
                    value = map.get(key);
                    while (map.containsKey(value(1))) 
                        value(1) = [];
                    end
                   
                    
                    if (value(1) == 0 || size(value, 1) == 0) 
                        return
                    end
                    if (wList(key, value(1)) > maxSim)
                        father = key;
                        doProcess = value(1);
                    end
                end
                clusterType(doProcess) = clusterType(father);
                map.put(doProcess, indexArr(doProcess, :));
            end
        end
       %% TODO
        function [clusterType] = doAllocation3(clusterCenter, clusterType, KnnList, SnnList, RnnList, K, row)
            queue = zeros(0);
            [~,NCLUSTER] = size(clusterCenter);
            for i = 1 : NCLUSTER
                queue(end + 1) = clusterCenter(i);
            end
            while (size(queue) ~= 0)
                xi = queue(1);
                for i = 1 : K
                    x = KnnList(xi, i);
                    if (clusterType(x) == -1)
                        if (SnnList(xi, x) >= (K/2) && RnnList(x) >= K)
                            clusterType(x) = clusterType(xi);
                            queue(end + 1) = x;
                        end
                    end
                end
                queue(1) = [];
            end

            p = zeros(0);
            for i = 1 : row
                if (clusterType(i) == -1)
                    p(end + 1) = i;
                end
            end
            [~,HangNum] = size(p);
            A = zeros(HangNum, NCLUSTER);
            for i = 1 : HangNum
                for j = 1 : K
                    if (clusterType(KnnList(p(i), j)) ~= -1)
                        A(i,clusterType(KnnList(p(i), j))) = A(i,clusterType(KnnList(p(i), j))) + 1;
                    end
                end
            end
            for i = 1 : HangNum
                maxValue = -1;
                type = 0;
                for j = 1 : NCLUSTER
                    if (A(i,j) > maxValue)
                        maxValue = A(i,j);
                        type = j;
                    end
                end
                clusterType(p(i)) = type;
            end
        end
        %% 局部密度2
        function [rho, wList, RnnList, SnnList, KnnList] = getLocalDensity2(distMatrix, K)
            [row,~]=size(distMatrix);
            KnnList = zeros(row, K); %存index
            sortDist = zeros(row, row);

            for i = 1 : row
                [sortDist(i, :),indexArr] = sort(distMatrix(i, :));
                for j = 1 : K  
                    KnnList(i, j) = indexArr(j + 1);
                end
            end
 
            SnnList = zeros(row, row);
            wList = zeros(row, row);
            for i = 1 : row - 1
                for j = i + 1 : row
                    tmpList = intersect(KnnList(i, :),KnnList(j, :));
                    SnnList(i,j) = length(tmpList);
%                    tmp = (SnnList(i,j) / K) - (distMatrix(i,j) * distMatrix(i,j));
                    tmp = (SnnList(i,j) / K) - distMatrix(i,j);
                    wList(i,j) = exp(tmp);
                end
            end
            wList = wList + wList'; %得到对称矩阵
            RnnList = zeros(1, row);
            SnnList = SnnList + SnnList';
            
            for i = 1 : row
                for j = 1 : row
                    if (ismember(i, KnnList(j,:)))
                        RnnList(i) = RnnList(i) + 1;
                    end
                end
            end
            
            aveList = zeros(1, row);
            for i = 1 : row
                tmp = 0;
                for j = K + 2 : row
                    tmp = tmp + sortDist(i,j);
                end
                aveList(i) = tmp / (row - K);
            end
            
            zList = zeros(row, row);
            for i = 1 : row
                for j = 1 : row
                    if (i == j) 
                         continue;
                    end
                     if (ismember(j, KnnList(i,:)))
                         % zList(i, j) = exp(-distMatrix(i, j)*distMatrix(i, j));
                         zList(i, j) = exp(-distMatrix(i, j));
                     else
                          tmp = exp(-distMatrix(i, j));
%                          zList(i, j) = tmp / (tmp + 1);
                            zList(i, j) = tmp / (aveList(i) + 1);
%                            zList(i, j) = tmp * aveList(i);
                     end
                end
            end
            rho =  zeros(1, row);
            for i = 1 : row
                rho(i) = RnnList(i) + (sum(zList(i,:)) / K);
            end
            
            
            
            
            a = 1;
        end
    end
end