function [tracker,dk] = treetouch(x,y,nodes)
%Checks if trees have touched each other 
%Returns index of intersection node also
tracker = 0;
dk = 0;
for i = 1:size(nodes,1)
   dist = ((x - nodes(i,2))^2 + (y - nodes(i,3))^2)^0.5;
   if dist < 5
      tracker = 1;
      dk = nodes(i,1);
   end
end
end

