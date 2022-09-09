order=20;
% mat=0:.1:1;
% mat=[mat; mat];
mat = rand(600,700);
t1=tic;
res=hermiteHJarda(order,mat);
t1=toc(t1);
t2=tic;
% ref=hermiteh(order,mat);
ref=hermiteHJarda2(order,mat);
t2=toc(t2);
% isequal(res,ref)
differ=max(max(abs(res-ref)));
disp(['t1 = ',num2str(t1,5),'  t2 = ',num2str(t2,5),'  difference: ', num2str(differ)]);
% plot_ampl(res);
