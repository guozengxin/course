
totalInErr = 0.0;
totalOutErr = 0.0;
count = 2000;
for i=1:count
    x = unifrnd (-1, 1, [20, 1]);
    x = sort(x);
    y = sign(x);
    index = randi([1 20], [1, 4]);
    for k =1:4
        y(index(k)) = -y(index(k));
    end
    [minErr, s, theta] = minInErr(x, y);
    totalInErr = totalInErr + minErr;
    totalOutErr = totalOutErr + outErr(s, theta);
end
fprintf('In Error %f\n', totalInErr / count);
fprintf('Out Error %f\n', totalOutErr / count);


