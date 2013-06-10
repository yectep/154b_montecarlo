function spar = comp_plot(num,cent,comp)

figure(99)
hold on
axis equal

c = 1.524; %chord in meters

%plot skin
for x=0:0.0001:0.75
    plot(x*c,getpoint(x,'top',c))
    plot(x*c,getpoint(x,'bot',c))
end

%plot stringers & caps

num_comp = num(1);
num_str = num(2);
num_cap = num(3);
num_spar = num(4);

% plot stringers
for n=1:num_str
    plot(comp(n,1),comp(n,2),'bx')
end

% plot caps
for n=num_comp-num_spar-num_cap+1:num_comp-num_spar
    plot(comp(n,1),comp(n,2),'rs')
end

% plot spars
ind=1;
for n=num_comp-num_spar+1:num_comp
    y_t = getpoint(comp(n,1)/c,'top',c);
    y_b = getpoint(comp(n,1)/c,'bot',c);
    spar = y_b:0.001:y_t;
    for m=1:length(spar)
        plot(comp(n,1),spar(m),'k')
    end
    ind=ind+1;
end

plot(cent(1),cent(2),'go')
end

