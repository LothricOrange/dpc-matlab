function [ari]=GetAri(answer,cluster)
    [p,o]=meshgrid(answer,answer);
    answerPair=~squareform(p~=o);
    [p,o]=meshgrid(cluster,cluster);
    resultPair=~squareform(p~=o);
    a=sum(answerPair&resultPair);
    b=sum(answerPair&~resultPair);
    c=sum(~answerPair&resultPair);
    d=sum(~answerPair&~resultPair);
    ari=2*(a*d-b*c)/((a+b)*(b+d)+(a+c)*(c+d));
end