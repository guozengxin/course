function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

axis([30,100,30,100]);
X1 = X(find(y == 0), :);
X2 = X(find(y == 1), :);
plot(X1(:, 1), X1(:, 2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);
plot(X2(:, 1), X2(:, 2), 'b+', 'LineWidth', 2, 'MarkerSize', 7);



% =========================================================================



hold off;

end
