function y=signo_ejer3(y)
    [~,c]=size(y);
    if(c==1)
        y(y>=0)=1;
        y(y<0)=-1;
    else    
        [~,index]=max(y');
        y=-ones(size(y));
        for i=1:length(index)
            y(i,index(i))=1;
        end
    end
end
