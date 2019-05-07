function  Gauss_Seidel( mat,vect,initial,maxIterations,error )
%format long;
[rows,cols] = size(mat);
errorMatrix=vect;
valuesMatrix=vect;
ready=false;
while(~ready)
    ready=true;
    for r=1:rows
        if mat(r,r)==0
            for j=1:rows
                if mat(j,r)>0
                    mat([j r],:)=mat([r j],:);
                    ready=false;
                end
            end
        end
    end
end

for itr=1:maxIterations
    for r = 1:rows
        if(mat(r,r)~=0)
            temp=vect(r);
            for c = 1:cols
                if(r~=c)
                    temp=temp-(mat(r,c)*initial(c));
                end
            end
            old =initial(r);
            initial(r)=temp/mat(r,r);
            errors(r)=abs(old-initial(r));
        else
            
        end
        maxim=max(errors);
    end
    errorMatrix=[errorMatrix;errors];
    valuesMatrix=[valuesMatrix;initial];
    itr=itr+1;
    if(maxim<error)
        break;
    end
end
errorMatrix(1,:) = [];
valuesMatrix(1,:) = [];
disp(valuesMatrix);
disp(errorMatrix);
end
