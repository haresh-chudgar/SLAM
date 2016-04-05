i = 0;

theta = [-0.0446854, -0.0451595, -0.0639385, -0.0625954, 0.0471196];
oX = [-1.62477, 6.58814, 7.39107, 5.33736,-4.01768];
oY = [6.8786, 7.26576, 8.39026, 6.21391, -8.43267];

path = sprintf('pointclouds/pointCloud_%d.csv', 0);
M_1 = csvread(path);
M_1 = M_1(2:end,:);
    
for pointCloudIndex=1:5
    
    cost = 0;
    
    path = sprintf('pointclouds/pointCloud_%d.csv', pointCloudIndex);
    M_2 = csvread(path);
    M_2 = M_2(2:end,:);

    for pointCloudIndex_2=pointCloudIndex:-1:1
        for index=1:180
            tempX = M_2(index,1);
            tempY = M_2(index,2);
            M_2(index,1) = tempX*cos(theta(pointCloudIndex_2)) - tempY*sin(theta(pointCloudIndex_2)) + oX(pointCloudIndex_2);
            M_2(index,2) = tempX*sin(theta(pointCloudIndex_2)) + tempY*cos(theta(pointCloudIndex_2)) + oY(pointCloudIndex_2);
        end
    end
    
    for index=1:180
        cost = cost + sqrt((M_1(index,1) - M_2(index,1))^2 + (M_1(index,2) - M_2(index,2))^2);
    end
    
    figure;
    hold on
    scatter(M_1(:,1), M_1(:,2));
    scatter(M_2(:,1), M_2(:,2), 'r');
    hold off
    
    disp(sprintf('%f', cost));
    
%     figure;
% 
%     subplot(2,1,1);
%     hold on
%     scatter(M_1(:,1), M_1(:,2));
%     scatter(M_2(:,3), M_2(:,4), 'r');
%     hold off
% 
%     subplot(2,1,2);
%     hold on
%     scatter(M_1(:,1), M_1(:,2));
%     scatter(M_3(:,1), M_3(:,2), 'r');
%     hold off
end


