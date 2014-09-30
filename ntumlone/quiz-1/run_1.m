data = load('15_train.dat');
y = data(:, 5);
m = length(y);
X = [ones(m, 1), data(:,1:4)];

w = zeros(size(X, 2), 1);
i = 0;
oknum = 0;
[iterNum, w] = cyclePla(X, y, w, 1:m);
fprintf('Question-15:\n');
fprintf('IterNum: %d\n', iterNum);
fprintf('weight: ');
w
fprintf('\n');

times = 2000;
total = 0;
for i = 1:times
    w = zeros(size(X, 2), 1);
    indexList = randperm(m);
    [iterNum, w] = cyclePla(X, y, w, indexList);
    total += iterNum;
end
fprintf('Question-16:\n');
fprintf('average updates: %d\n', total / times);

times = 2000;
total = 0;
for i = 1:times
    w = zeros(size(X, 2), 1);
    indexList = randperm(m);
    [iterNum, w] = cyclePla(X, y, w, indexList, 0.5);
    total += iterNum;
end
fprintf('Question-17:\n');
fprintf('average updates: %d\n', total / times);
