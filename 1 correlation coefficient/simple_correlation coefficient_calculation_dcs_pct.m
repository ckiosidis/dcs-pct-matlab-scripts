clear
clc

n=2^24
x=randi(10,[1,n]);
xx=x.^2;
jm = findResource;
pj = createJob(jm);
set(pj, 'MinimumNumberOfWorkers',1);
set(pj, 'MaximumNumberOfWorkers',4);
obj(1) = createTask(pj, @sum, 1, {x(1:n/2)});
obj(2) = createTask(pj, @sum, 1, {x(n/2+1:n)});
obj(3) = createTask(pj, @sum, 1, {xx(1:n/2)});
obj(4) = createTask(pj, @sum, 1, {xx(n/2+1:n)});

tic
submit(pj);
waitForState(pj);
out = getAllOutputArguments(pj);
variance = 1/(n-1) * ((out{3}+out{4}) - (out{1} + out{2})^2/n);
toc

destroy(pj);
variance
