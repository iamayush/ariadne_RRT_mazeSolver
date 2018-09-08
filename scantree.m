function [x_near,y_near,k_near] = scantree(x,y,nodes)
%Scans tree for node nearest to random point selected

min_dist = 1000;
for i = 1:size(nodes,1)
   dist = ((x - nodes(i,2))^2 + (y - nodes(i,3))^2)^0.5;
   
   if dist < min_dist
      min_dist = dist;
      x_near = nodes(i,2); %x-coordinate of nearest node
      y_near = nodes(i,3); %y-coordinate
      k_near = nodes(i,1); %index
   end
end
end

