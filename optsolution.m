function final_array = optsolution(x,y,z,phi)
mat =  findJointAngles_O(x, y, z, phi)
arb = Arbotix('port', 'COM4', 'nservos', 5);
curr_pos = arb.getpos()  %no argument is given to get the anglular position of all servo motors.

%x = [90*pi/180, 135*pi/180, 0, 40*pi/180] 

opt = 0;
arr = [];
mat(4,4)
for i=1:4
    first = abs(mat(i,1)-curr_pos(1));
    second = abs(mat(i,2)-curr_pos(2));
    third = abs(mat(i,3)-curr_pos(3));
    fourth = abs(mat(i,4)-curr_pos(4));

    opt = first + second + third + fourth  ;
    arr(i) = opt;
    opt = 0;
end
final = min(arr);
index = find(arr==final);
final_array = mat(index,:);