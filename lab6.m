arb = Arbotix('port','COM3', 'nservos',5)
%idle position
position = [0 0 0 0 0];
arb.setpos(position)
%pick coordinates given by user
prompt = "Give pick coordinates";
pick_pos = input(prompt)
x = pick_pos(1); y = pick_pos(2); z = pick_pos(3); phi = pick_pos(4)
sol = optsolution(x, y, z, phi)
sol(5) = 0
%go to a certain height
position(2) = position(2)+1
if position(2) == position(2)+1
 arb = Arbotix('port','COM4', 'nservos',5)
 arb.setpos(position)
end
%open jaws
position(5) = 0 %jaws are already open, can skip this step
if pick_pos == 1
 prompt = "Please give pick coordinates";
 pick_pos = input(prompt)
 x = pick_pos(1)
 y = pick_pos(2)
 z = pick_pos(3)
 phi = pick_pos(4)
 sol = optsolution(x, y, z, phi)
 sol(5) = 0
else
 arb = Arbotix('port','COM4', 'nservos',5)
 arb.setpos(sol)
end
%go to a certain height
if sol == [sol(1) sol(2) sol(3) sol(4) 0]
 sol(2) = sol(2)-0.6
 arb = Arbotix('port','COM4', 'nservos',5)
 arb.setpos(sol)
end
%pick coordinates given by user
prompt = "Give place coordinates";
place_pos = input(prompt)
%close jaws to pick the object
if sol == [sol(1) sol(2) sol(3) sol(4) 0]
 sol(5) = 1.1;
 arb = Arbotix('port','COM4', 'nservos',5)
 arb.setpos(sol)
end
% go to a height above the pick position
if sol == [sol(1) sol(2) sol(3) sol(4) sol(5)]
 sol(2) = 0.4;
 arb = Arbotix('port','COM4', 'nservos',5)
 arb.setpos(sol)
end
x1 = place_pos(1); y1 = place_pos(2); z1 = place_pos(3); phi1 = place_pos(4);
sol_place = optsolution(x1, y1, z1, phi1)
sol_place(5) = sol(5);
%go to the place position
if sol == [sol(1) sol(2) sol(3) sol(4) sol(5)]
 arb = Arbotix('port','COM4', 'nservos',5)
 arb.setpos(sol_place)
end
%open jaws to drop the object
if sol_place == [sol_place(1) sol_place(2) sol_place(3) sol_place(4)
sol_place(5)]
 sol_place(5) = 0;
 arb = Arbotix('port','COM4', 'nservos',5)
 arb.setpos(sol_place)
end