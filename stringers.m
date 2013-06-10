function [str_loc] = stringers(top_str,str_loc,num_str)

% Order stringers clockwise from leading edge
temp = [0 0]; % temporary storage to switch positions
% Place top stringers first in matrix
for m = 1:top_str
    if str_loc(m,2) < 0
       temp = str_loc(m,:);
       for n = 1:(num_str-top_str)
            if str_loc(top_str+n,2) > 0
                str_loc(m,:) = str_loc(top_str+n,:);
                str_loc(top_str+n,:) = temp;
                break;
            end
       end
    end 
end
% Order elements clockwise
pos = 0;
% Top skin (leading to trailing)
for m = 1:top_str
    for n = 1:top_str
        if m < n && str_loc(m,1) > str_loc(n,1)
            if temp(1) == 0 || str_loc(n,1) < temp(1)
                temp = str_loc(n,:);
                pos = n;
            end
        elseif m > n && str_loc(m,1) < str_loc(n,1)
            if temp(1) == 0 || str_loc(n,1) > temp(1)
                temp = str_loc(n,:);
                pos = n;
            end
        end
    end
    if pos ~= 0
        str_loc(pos,:) = str_loc(m,:);
        str_loc(m,:) = temp;
        temp = [0 0];
    end
    pos = 0;
end
% Bottom skin (trailing to leading)
for j = top_str+1:num_str
    for k = top_str+1:num_str
        if j < k && str_loc(j,1) < str_loc(k,1)
            if temp(1) == 0 || str_loc(k,1) > temp(1)
                temp = str_loc(k,:);
                pos = k;
            end
        elseif j > k && str_loc(j,1) > str_loc(k,1)
            if temp(1) == 0 || str_loc(k,1) < temp(1)
                temp = str_loc(k,:);
                pos = k;
            end
        end
    end
    if pos ~= 0
        str_loc(pos,:) = str_loc(j,:);
        str_loc(j,:) = temp;
        temp = [0 0];
    end
    pos = 0;
end

end