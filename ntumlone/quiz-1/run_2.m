data = load('18_train.dat');
y = data(:, 5);
m = length(y);
X = [ones(m, 1), data(:,1:4)];

data2 = load('18_test.dat');
yVerify = data2(:, 5);
mVerify = length(yVerify);
XVerify = [ones(m, 1), data2(:,1:4)];

total_ep = 0;
for i = 1:2000
    % w = zeros(size(X, 2), 1);
    w = rand(size(X,2), 1);
    iterNum = 50;
    indexList = randperm(m);
    [w] = pocket(X, y, w, iterNum, indexList);
    w
    ep = (mVerify - verify(XVerify, yVerify, w)) / mVerify;
    fprintf('Error Percent %d: %f', i, ep);
    total_ep += ep;
    fprintf('\n');
end
fprintf('Question-18:\n');
fprintf('Average Error Percent: %f\n\n', total_ep / 2000);
