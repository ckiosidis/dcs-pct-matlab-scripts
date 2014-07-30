clear
clc
n=2^24;
x=randi(10,[n,1]);
xx=x.^2;
y=randi(10,[n,1]);
yy=y.^2;
jm = findResource;
pj = createJob(jm);
set(pj, 'MinimumNumberOfWorkers',1);
set(pj, 'MaximumNumberOfWorkers',32);
set(pj, 'FileDependencies', {'arraySumMult.m'});

%sum xi
obj(1) = createTask(pj, @sum, 1, {x(1:n/6)});
obj(2) = createTask(pj, @sum, 1, {x(n/6+1:2*n/6)});
obj(3) = createTask(pj, @sum, 1, {x(2*n/6+1:3*n/6)});
obj(4) = createTask(pj, @sum, 1, {x(3*n/6+1:4*n/6)});
obj(5) = createTask(pj, @sum, 1, {x(4*n/6+1:5*n/6)});
obj(6) = createTask(pj, @sum, 1, {x(5*n/6+1:6*n/6)});

%sum yi
obj(7) = createTask(pj, @sum, 1, {y(1:n/6)});
obj(8) = createTask(pj, @sum, 1, {y(n/6+1:2*n/6)});
obj(9) = createTask(pj, @sum, 1, {y(2*n/6+1:3*n/6)});
obj(10) = createTask(pj, @sum, 1, {y(3*n/6+1:4*n/6)});
obj(11) = createTask(pj, @sum, 1, {y(4*n/6+1:5*n/6)});
obj(12) = createTask(pj, @sum, 1, {y(5*n/6+1:6*n/6)});

%sum xi^2
obj(13) = createTask(pj, @sum, 1, {xx(1:n/6)});
obj(14) = createTask(pj, @sum, 1, {xx(n/6+1:2*n/6)});
obj(15) = createTask(pj, @sum, 1, {xx(2*n/6+1:3*n/6)});
obj(16) = createTask(pj, @sum, 1, {xx(3*n/6+1:4*n/6)});
obj(17) = createTask(pj, @sum, 1, {xx(4*n/6+1:5*n/6)});
obj(18) = createTask(pj, @sum, 1, {xx(5*n/6+1:6*n/6)});

%sum yi^2
obj(19) = createTask(pj, @sum, 1, {yy(1:n/6)});
obj(20) = createTask(pj, @sum, 1, {yy(n/6+1:2*n/6)});
obj(21) = createTask(pj, @sum, 1, {yy(2*n/6+1:3*n/6)});
obj(22) = createTask(pj, @sum, 1, {yy(3*n/6+1:4*n/6)});
obj(23) = createTask(pj, @sum, 1, {yy(4*n/6+1:5*n/6)});
obj(24) = createTask(pj, @sum, 1, {yy(5*n/6+1:6*n/6)});

%sum xi*yi
obj(25) = createTask(pj, @arraySumMult, 1, {x(1:n/8),     	    y(1:n/8), n/8});
obj(26) = createTask(pj, @arraySumMult, 1, {x(n/8+1:2*n/8), 	y(n/8+1:2*n/8), n/8});
obj(27) = createTask(pj, @arraySumMult, 1, {x(2*n/8+1:3*n/8),   y(2*n/8+1:3*n/8),n/8});
obj(28) = createTask(pj, @arraySumMult, 1, {x(3*n/8+1:4*n/8),   y(3*n/8+1:4*n/8),n/8});
obj(29) = createTask(pj, @arraySumMult, 1, {x(4*n/8:5*n/8), 	y(4*n/8:5*n/8), n/8});
obj(30) = createTask(pj, @arraySumMult, 1, {x(5*n/8+1:6*n/8),   y(5*n/8+1:6*n/8), n/8});
obj(31) = createTask(pj, @arraySumMult, 1, {x(6*n/8+1:7*n/8),   y(6*n/8+1:7*n/8),n/8});
obj(32) = createTask(pj, @arraySumMult, 1, {x(7*n/8+1:n), 		y(7*n/8+1:n),n/8});

tic
submit(pj);
waitForState(pj);
out = getAllOutputArguments(pj);


sxi=out{1}+out{2}+out{3};
syi=out{4}+out{5}+out{6};
sxxi=out{7}+out{8}+out{9};
syyi=out{10}+out{11}+out{12};
sxyi=out{13}+out{14}+out{15}+out{16};
p= ((n*sxyi) - sxi*syi)/(sqrt( n*sxxi - sxi^2 )*(sqrt( n*syyi - syi^2) ));

time32=toc

destroy(pj);
%variance1
p

tic
p2= (n*sum(x.*y)-sum(x)*sum(y))/(sqrt(n*sum(x.^2)-(sum(x))^2)  *  sqrt((n*sum(y.^2)-(sum(y))^2)));
toc