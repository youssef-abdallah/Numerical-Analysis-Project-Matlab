function  [valuesMatrix,errorMatrix] = Gauss_Seidel( mat,vect,initial,maxIterations,error,handles)
format long;
tic;
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
                    vect([j r])=vect([r j]);
                    errorMatrix([j r])=errorMatrix([r j]);
                    valuesMatrix([j r])=valuesMatrix([r j]);
                    ready=false;
                    break;
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
set(handles.time,'String',toc);
end
