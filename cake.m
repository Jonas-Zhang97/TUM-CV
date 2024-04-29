function Cake=cake(min_dist)
Cake = zeros(2.*min_dist+1);
for i=1:size(Cake,1)
    for j=1:size(Cake,2)
        if sqrt((i-min_dist-1)^2+(j-min_dist-1)^2)>min_dist
            Cake(i,j)=1;
        end
    end
end
Cake=logical(Cake);
end