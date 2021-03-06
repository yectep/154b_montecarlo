function [str_areas,spar_areas,cap_areas,skin_areas] = place_areas(num_str,alum,str_t,spar_t,cap_t,skin_t,c,str_loc,fs_loc,pts,top,bot)

% Place stringer areas
str_areas = zeros(num_str,3);
for b = 1:num_str
    str_areas(b,1) = str_loc(b,1);
    str_areas(b,2) = str_loc(b,2);
    str_areas(b,3) = 1.33E-4/.0016*alum(str_t);
end

% Place spar areas
spar_areas = zeros(2,3);
% Forward spar
spar_areas(1,1) = fs_loc*c;
spar_areas(1,2) = getpoint(fs_loc,'mid',c);
spar_areas(1,3) = alum(spar_t)*(getpoint(fs_loc,'top',c)-getpoint(fs_loc,'bot',c));
% Rear spar (always at 75% chord)
spar_areas(2,1) = 0.75*c;
spar_areas(2,2) = getpoint(0.75,'mid',c);
spar_areas(2,3) = alum(spar_t)*(getpoint(0.75,'top',c)-getpoint(0.75,'bot',c));

% Place spar cap areas (clockwise from leading edge)
cap_areas = zeros(6,3);
% Forward-forward (rows 1 and 6)
x_cap_1 = fs_loc*c-alum(spar_t)/2-alum(cap_t)/2; % Temp storage
cap_areas(1,1) = x_cap_1;
cap_areas(6,1) = x_cap_1;
cap_areas(1,2) = getpoint(x_cap_1/c,'top',c)-alum(skin_t)-alum(cap_t);
cap_areas(6,2) = getpoint(x_cap_1/c,'bot',c)+alum(skin_t)+alum(cap_t);
% Mid-forward (rows 2 and 5)
x_cap_2 = fs_loc*c+alum(spar_t)/2+alum(cap_t)/2;
cap_areas(2,1) = x_cap_2;
cap_areas(5,1) = x_cap_2;
cap_areas(2,2) = getpoint(x_cap_2/c,'top',c)-alum(skin_t)-alum(cap_t);
cap_areas(5,2) = getpoint(x_cap_2/c,'bot',c)+alum(skin_t)+alum(cap_t);
% Rear (rows 3 and 4)
x_cap_3 = 0.75*c-alum(spar_t)/2-alum(cap_t)/2;
cap_areas(3,1) = x_cap_3;
cap_areas(4,1) = x_cap_3;
cap_areas(3,2) = getpoint(x_cap_3/c,'top',c)-alum(skin_t)-alum(cap_t);
cap_areas(4,2) = getpoint(x_cap_3/c,'bot',c)+alum(skin_t)+alum(cap_t);
% Areas
cap_areas(1:6,3) = alum(cap_t)^2;

% Place skin areas
top_skin_areas = zeros(round(0.75*pts)-1,3);
bot_skin_areas = zeros(round(0.75*pts)-1,3);
for i = 1:round(0.75*pts)-1
    x = i*c/pts+((i+1)*c/pts-i*c/pts)/2; % Place centroid of each piece between skin points
    l_top = sqrt((top(i+1)-top(i))^2+(c/pts)^2);
    l_bot = sqrt((bot(i+1)-bot(i))^2+(c/pts)^2);
    top_skin_areas(i,1) = x;
    bot_skin_areas(length(bot_skin_areas)-(i-1),1) = x;
    top_skin_areas(i,2) = top(i)+(top(i+1)-top(i))/2;
    bot_skin_areas(length(bot_skin_areas)-(i-1),2) = bot(i)+(bot(i+1)-bot(i))/2;
    top_skin_areas(i,3) = alum(skin_t)*l_top;
    bot_skin_areas(length(bot_skin_areas)-(i-1),3) = alum(skin_t)*l_bot;
end

% Combine top and bottom skin into single matrix
skin_areas = [top_skin_areas; bot_skin_areas];
% Create area at leading edge point and add as first element
LE_area = alum(skin_t)*(sqrt(top_skin_areas(1,1)^2+top_skin_areas(1,2)^2)+sqrt(bot_skin_areas(1,1)^2+bot_skin_areas(1,2)^2));
skin_areas = [0 0 LE_area; skin_areas];

end