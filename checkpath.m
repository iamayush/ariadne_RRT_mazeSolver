function [p] = checkpath(x,y,x_near,y_near,x_obs,y_obs)
%Checks if path between (x,y) and (x_near,y_near)
%hits or intersects with obstacles

p = 1;

x_path = x_near:(x - x_near)/100:x ;
y_path = y_near:(y - y_near)/100:y ;

touch_thresh = 10;
for i = 1:size(x_path,2)
   for j = 1:size(x_obs,2)
       dis = ( (x_path(i) - x_obs(j))^2 + (y_path(i) - y_obs(j))^2 )^0.5;
       if dis < touch_thresh
          p = 0; 
       end
   end
end

% in_obs = inpolygon(x_path,y_path,x_obs1,y_obs1);
% p1 = (numel(x_path(in_obs)));
% 
% in_obs = inpolygon(x_path,y_path,x_obs2,y_obs2);
% p2 = (numel(x_path(in_obs)));
% 
% p = ~(p1 + p2);
end

