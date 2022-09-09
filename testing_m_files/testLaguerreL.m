order=10;
alpha=30;
% mat=0:.1:1;
% mat=[mat; mat];
mat = rand(600,700);
t1=tic;
res=laguerreLJarda(order,alpha,mat);
t1=toc(t1);
t2=tic;
% ref=laguerrel(order,alpha,mat);
% ref=laguerreL(order,alpha,mat);
ref=laguerreLJarda2(order,alpha,mat);
t2=toc(t2);
% isequal(res,ref)
differ=max(max(abs(res-ref)));
disp(['t1 = ',num2str(t1,5),'  t2 = ',num2str(t2,5),'  difference: ', num2str(differ)]);
% plot_ampl(res);