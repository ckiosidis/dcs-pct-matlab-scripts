clear
clc
n=2^6+1;
x=randi(10,[1,n]);
y=randi(10,[1,n]);
jm = findResource;
pj = createJob(jm);
set(pj, 'MinimumNumberOfWorkers',1);
set(pj, 'MaximumNumberOfWorkers',32);
set(pj, 'FileDependencies', {'d.m'});
worker=0;
for i=2:floor(n/2)+1
    j=n+2-i;
    worker=worker+1;
    obj(worker)= createTask(pj, @d, 1 ,{x,y,i,j} );
end

tic
submit(pj);
waitForState(pj);
out = getAllOutputArguments(pj);

dist=zeros(length(x),length(y));
for i=2:n
    for j=1:i-1
        for k=1:worker
           if( out{k}(i,j)~= 0 )
              dist(i,j)= out{k}(i,j);
              dist(j,i)=out{k}(i,j);
           end
        end
    end
    
end

%for i=1:worker
%   disp(out{i}); 
%end

disp(dist);
time32=toc

destroy(pj);

