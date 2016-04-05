i = 0;

theta = [-0.0446854, -0.0451595, -0.0639385, -0.0625954, 0.0471196];
oX = [-1.62477, 6.58814, 7.39107, 5.33736,-4.01768];
oY = [6.8786, 7.26576, 8.39026, 6.21391, -8.43267];

for pointCloudIndex=1:5
    path = sprintf('pointclouds/pointCloud_%d.csv', pointCloudIndex-1);
    M_1 = csvread(path);
    M_1 = M_1(2:end,:);
    
    path = sprintf('pointclouds/pointCloud_%d.csv', pointCloudIndex);
    M_2 = csvread(path);
    M_2 = M_2(2:end,:);
    
    cost = 0;
    prevCost = 0;
    M_3 = M_1(:,1:2);
    nRows = size(M_3);
    nRows = nRows(1);
    for index=1:180
        tempX = M_3(index,1);
        tempY = M_3(index,2);
        M_3(index,1) = tempX*cos(theta(pointCloudIndex)) - tempY*sin(theta(pointCloudIndex)) + oX(pointCloudIndex);
        M_3(index,2) = tempX*sin(theta(pointCloudIndex)) + tempY*cos(theta(pointCloudIndex)) + oY(pointCloudIndex);

        cost = cost + sqrt((M_3(index,1) - M_1(index,1))^2 + (M_3(index,2) - M_1(index,2))^2);
        prevCost = prevCost + sqrt((M_2(index,3) - M_1(index,1))^2 + (M_2(index,4) - M_1(index,2))^2);
    end
    disp(sprintf('%f %f', cost, prevCost));
    
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
end

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



