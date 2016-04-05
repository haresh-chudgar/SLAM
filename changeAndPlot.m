i = 0;

path = sprintf('pointclouds/pointCloud_%d.csv', i);
M_1 = csvread(path);
M_1 = M_1(2:end,:);

path = sprintf('pointclouds/pointCloud_%d.csv', i+1);
M_2 = csvread(path);
M_2 = M_2(2:end,:);

%Cumulative- theta: -0.087548 oX: -0.79922 oY: 9.53891
theta = -0.087548;
oX = -0.79922;
oY = 9.53891;

theta = 1.83269e-06;
oX = 0.0763208;
oY = -0.00488601;

%theta = -0.14085;
%oX = 0;
%oY = 0;

cost = 0;
M_3 = M_1(:,1:2);
nRows = size(M_3);
nRows = nRows(1);
for index=1:180
    tempX = M_3(index,1);
    tempY = M_3(index,2);
    M_3(index,1) = tempX*cos(theta) - tempY*sin(theta) + oX;
    M_3(index,2) = tempX*sin(theta) + tempY*cos(theta) + oY;
    
    cost = cost + sqrt((M_3(index,1) - M_1(index,1))^2 + (M_3(index,2) - M_1(index,2))^2);
end
disp(cost)
% figure;
% 
% subplot(2,1,1);
% hold on
% scatter(M_1(:,1), M_1(:,2));
% scatter(M_2(:,1), M_2(:,2), 'r');
% hold off
% 
% subplot(2,1,2);
% hold on
% scatter(M_1(:,1), M_1(:,2));
% scatter(M_2(:,3), M_2(:,4), 'r');
% hold off


figure;

subplot(2,1,1);
hold on
scatter(M_1(:,1), M_1(:,2));
scatter(M_2(:,3), M_2(:,4), 'r');
hold off

subplot(2,1,2);
hold on
scatter(M_1(:,1), M_1(:,2));
scatter(M_3(:,1), M_3(:,2), 'r');
hold off
