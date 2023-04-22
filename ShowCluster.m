function  ShowCluster(data)
    %���ݸ�ʽΪ���У�ǰ�����Ƕ�ά���ݣ����һ�������  x,y,c  
    [~,col]=size(data);
    L=unique(data(:,col));
    N=length(L);
    lineStyles = linspecer(N);
    lineStyles=[[1,1,1];lineStyles];
    figure;
    for i=1:N
        ir = find(data(:,col)==L(i,1));         % ����������  
        if(~isempty(ir))
            if col>3
                scatter3(data(ir,1),data(ir,2),data(ir,3),'MarkerFaceColor',lineStyles(i+1,:),'MarkerEdgeColor',lineStyles(i+1,:));%,'Marker','.'
            else
                scatter(data(ir,1),data(ir,2),'MarkerFaceColor',lineStyles(i+1,:),'MarkerEdgeColor',lineStyles(i+1,:));          
            end
            hold on
        end

    end
    % hold off
    % title("���");

end

