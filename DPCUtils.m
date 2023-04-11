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
            for i = 1 : row
                for j = 1 : row
                     if (i == j) 
                        continue;
                    end
                    tmpList = intersect(KnnList(i, :),KnnList(j, :));
                    SnnList(i,j) = length(tmpList);
                    tmp = -distMatrix(i,j) * distMatrix(i,j) + (SnnList(i,j) / K);
                    wList(i,j) = exp(tmp);
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

            rho =  zeros(1, row);
            for i = 1 : row
                sum = 0;
                for j = 1 : row
                    if (i == j) 
                        continue;
                    end
                    if (sortDist(i, K + 1) >= distMatrix(i, j))
                        sum = wList(i, j) + sum;
                    end
                    if (aveList(i) >= distMatrix(i, j))
                        tmp = distMatrix(i, j) / (j - K);
                        sum = exp(- tmp * tmp) + sum;
                    end
                end
                rho(i) = sum;
            end
        end
        
        
        %% 高斯核
        function [rho] = getGaussianKernel(distMatrix, dc)
            [row,~] = size(distMatrix);
            rho =  zeros(1, row);
            for i = 1 : row - 1  
               for j = i + 1 : row  
                  tmp = distMatrix(i,j) / dc;
                  augend = exp(-tmp * tmp);
                  rho(i) = rho(i) + augend;  
                  rho(j) = rho(j) + augend;  
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
    end
end