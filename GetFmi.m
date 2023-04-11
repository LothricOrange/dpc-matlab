function [fmi]=GetFmi(answer,cluster)
      [p,o]=meshgrid(answer,answer);
      answerPair=~squareform(p~=o);
      [p,o]=meshgrid(cluster,cluster);
      resultPair=~squareform(p~=o);
      tp=sum(answerPair&resultPair);
      fp=sum(answerPair&~resultPair);
      fn=sum(~answerPair&resultPair);
      fmi=tp/sqrt((tp+fp)*(tp+fn));      
end