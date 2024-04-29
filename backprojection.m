function [repro_error] = backprojection(correspondences,P1,Image2,T,R,K)

num_corr = size(correspondences,2);

x2 = correspondences(3:4,:);

P2 = R*P1+T;
schlange_x2_hom = K*P2;

schlange_x2_hom = (1./schlange_x2_hom(3,:)).*schlange_x2_hom;
schlange_x2 = schlange_x2_hom(1:2,:);

figure(1)
imshow(Image2)
hold on
plot(x2(1,:),x2(2,:),'oy',schlange_x2(1,:),schlange_x2(2,:),'og')
hold on
for i=1:num_corr
    q = num2str(i); %#ok<NASGU> 
    text(x2(1,i),x2(2,i),'q');
    text(schlange_x2(1,i),schlange_x2(2,i),'q');
end
hold on
for i=1:num_corr
    x_start_end = [x2(1,i),schlange_x2(1,i)];
    y_start_end = [x2(2,i),schlange_x2(2,i)];
    line(x_start_end,y_start_end,'Color','blue')
end

E_single = zeros(1,num_corr);
for i=1:num_corr
    E_single(1,i) = norm(x2(:,i)-schlange_x2(:,i));
end
repro_error = (1/num_corr)*sum(E_single);

end