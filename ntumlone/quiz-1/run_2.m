data = load('18_train.dat');
y = data(:, 5);
m = length(y);
X = [ones(m, 1), data(:,1:4)];


data2 = load('18_test.dat');
yVerify = data2(:, 5);
mVerify = length(yVerify);
XVerify = [ones(m, 1), data2(:,1:4)];

total_ep = 0;
times = 200;
for i = 1:times
    w = randn(size(X,2), 1);
    iterNum = 100;
    indexList = randperm(m);
    [w, wPocket] = pocket(X, y, w, iterNum, indexList);
    ep = (verify(XVerify, yVerify, wPocket)) / mVerify;
    fprintf('Error Percent %d: %f', i, ep);
    total_ep += ep;
    fprintf('\n');
end
fprintf('Question-18:\n');
fprintf('Average Error Percent: %f\n\n', total_ep / times);
