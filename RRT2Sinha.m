function [ ] = RRT2Sinha(x_obs,y_obs)

%Starting position
x_init = 5;
y_init = -495;
plot(x_init,y_init,'g*');
hold on

%Final position
x_goal = 495;
y_goal = -5;
plot(x_goal,y_goal,'r*');
hold on

%%
d = 10; %Robot Step size
nodes_init = [1 x_init y_init 0];
nodes_goal = [1 x_goal y_goal 0];
tracker = 0;
fail = 0;

while ~tracker
    x_dir = 500*rand(1,1); %Random point selected
    y_dir = -500*rand(1,1);
    
    %Tree from Starting position
    %Fiding nearest node on tree
    [x_near,y_near,k_near] = scantree(x_dir,y_dir,nodes_init);
    
    %Taking step towards random point
    temp = ((y_dir - y_near)^2 + (x_dir - x_near)^2)^0.5;
    x = x_near + d*(x_dir - x_near)/temp;
    y = y_near + d*(y_dir - y_near)/temp;
    
    %Check if path doesn't hit obstacle
    pathtrue = checkpath(x,y,x_near,y_near,x_obs,y_obs);
    if pathtrue
        new_node = [nodes_init(end,1)+1 x y k_near];
        nodes_init = [nodes_init;new_node];
        L1 = line([x_near,x],[y_near,y]);
        set(L1,'lineWidth',3,'Color','yellow');
        hold on
        pause(0.000001);
        draw_initk = nodes_init(end,1);
        %Check if trees touched each other
        [tracker,dkg] = treetouch(x,y,nodes_goal);
        if tracker
           draw_goalk = dkg; %Node of intersection
        end
    end 
    
    if ~tracker
        %Tree from Goal position
        [x_near,y_near,k_near] = scantree(x_dir,y_dir,nodes_goal);
    
        temp = ((y_dir - y_near)^2 + (x_dir - x_near)^2)^0.5;
        x = x_near + d*(x_dir - x_near)/temp;
        y = y_near + d*(y_dir - y_near)/temp;
    
        pathtrue = checkpath(x,y,x_near,y_near,x_obs,y_obs);
        if pathtrue
            new_node = [nodes_goal(end,1)+1 x y k_near];
            nodes_goal = [nodes_goal;new_node];
            L2 = line([x_near,x],[y_near,y]);
            set(L2,'lineWidth',3,'Color','magenta');
            hold on
            pause(0.000001);
            draw_goalk = nodes_goal(end,1);
            %Check if trees intersected
            [tracker,dki] = treetouch(x,y,nodes_init);
            if tracker
                draw_initk = dki; %Node of intersection 
            end
        end 
    end
    if size(nodes_init,1)>8000 %Code takes too much time
        tracker = 1;
        fail = 1;              %Failed!
    end
end
%%
%Finding path
if ~fail
draw_k = draw_initk;%nodes_init(end,1);
while(draw_k ~= 1)
    pre_k = nodes_init(draw_k,4);
    L_init = line([nodes_init(draw_k,2),nodes_init(pre_k,2)],[nodes_init(draw_k,3),nodes_init(pre_k,3)]);
    set(L_init,'lineWidth',4,'Color','green');
    hold on
    draw_k = pre_k;
end

draw_k = draw_goalk;%nodes_goal(end,1);
while(draw_k ~= 1)
    pre_k = nodes_goal(draw_k,4);
    L_goal = line([nodes_goal(draw_k,2),nodes_goal(pre_k,2)],[nodes_goal(draw_k,3),nodes_goal(pre_k,3)]);
    set(L_goal,'lineWidth',4,'Color','green');
    hold on
    draw_k = pre_k;
end
end

if fail
   disp('FAILED!'); 
end
end