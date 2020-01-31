
    
    
  
%LAPA
% 
clear 
close all

max_iteration = 100;
nx = 10;
ny = 10;
V = zeros(nx,ny);
V(:,1) = 1; %Set Left BC to be 0
V_new = V;  

x_axis = [1 2 3 4 5 6 7 8 9 10];
y_axis = [1 2 3 4 5 6 7 8 9 10];

for i = 1:max_iteration
    for y = 1:ny
        for x = 2:nx-1
            if y == 1
                V_new(y,x) = V(y+1,x);
            elseif y == ny
                V_new(y,x) = V(y-1,x);
            else
                %V_new(y,x) = 0.25*sum(V(y,x-1) + V(y,x+1) +  V(y-1,x) + V(y+1,x));
                left = V(y,x-1);
                right = V(y,x+1);
                up = V(y-1,x);
                down = V(y+1,x); 
                V_new(y,x) = 0.25*sum([up down left right]);
            end
            
        end
    end
    V = V_new;
    figure(1);
    surf(x_axis,y_axis,V);
    title('Part 1: Free nodes on top and bottom');
    pause(0.001)
end

%% Part 2 - Changing BCs E filed and Vector Field
iteration = 50;
nx = 10;
ny = 10;
v = zeros(nx,ny);
v(:,1) = 1; %left BC to 1
v(:,nx) = 1; %right BC to 1
% v(1,:) = 0;
% v(ny,:) = 0;
v_new = v;

for i = 1:iteration
    for y = 2:ny-1
        for x = 2:nx-1
            left = v(y,x-1);
            right = v(y,x+1);
            up = v(y-1,x);
            down = v(y+1,x); 
            v_new(y,x) = 0.25*sum([up down left right]);
        end
    end
    v = v_new;
    figure(2);
    subplot(2,1,1)
    surf(x_axis,y_axis,v_new);
    title('Part 2');
    
    subplot(2,1,2)
    surf(x_axis,y_axis,imboxfilt(v_new,3));
    title('imboxfilt');

    [X, Y] = gradient(v_new);
    figure(3);
    quiver(x_axis,y_axis,-X,-Y);
    title('Quiver Plot');
    pause(0.001);
end











