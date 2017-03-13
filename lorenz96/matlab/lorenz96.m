%------------------------------------------------------------------------------
% Program   : lorenz96.m
% Author    : Celestine Woodruff
% Date      : 10/21/10
% Purpose   : Explore the effect of a small perturbation of the initial data on
%             the long term solution of the Lorenz 96 model.
%------------------------------------------------------------------------------

clear all; % clear variables
clc % clear window
clf % clear figures

J = 5;
J = J + 1; % shift to arrays beginning with 1
F = -12;
tfinal = 20;
h = 5E-4;

steps = ceil(tfinal/h);
u = zeros(J,steps);
v = u; % perturbed matrix
% generate inital values between -1 and 1
% rows of u are x's and columns are time steps
for i = 1:J
    u(i,1) = -1 + 2*rand;
    %u(i,1) = 0.1*i;
    
    % initial perturbed data
    v(i,1) = u(i,1)*(1 + (-1 + 2*rand)/100);
end

%u(:,1) = -1 + 2*rand;
%v(:,1) = u(:,1)*(1 + (-1 + 2*rand)/100);

t(1) = 0
method = 'rk';
%method = 'euler';

switch method
    case 'rk'
        % perform 4th order Runge-Kutta to iterate in time
        for i = 1:steps
            t(i+1) = i*h;
            disp(t(i+1))
            % iterate this step for the special cases first
            % j = 1
            f1 = (u(2,i) - u(J-1,i))*u(J,i) - u(1,i) + F;
            f2 = (u(2,i) - u(J-1,i))*(u(J,i) + h/2*f1) - u(1,i) - h/2*f1 + F;
            f3 = (u(2,i) - u(J-1,i))*(u(J,i) + h/2*f2) - u(1,i) - h/2*f2 + F;
            f4 = (u(2,i) - u(J-1,i))*(u(J,i) + h*f3) - u(1,i) - h*f3 + F;
            u(1,i+1) = u(1,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);
    
            % j = 2
            f1 = (u(3,i) - u(J,i))*u(1,i) - u(2,i) + F;
            f2 = (u(3,i) - u(J,i))*(u(1,i) + h/2*f1) - u(2,i) - h/2*f1 + F;
            f3 = (u(3,i) - u(J,i))*(u(1,i) + h/2*f2) - u(2,i) - h/2*f2 + F;
            f4 = (u(3,i) - u(J,i))*(u(1,i) + h*f3) - u(2,i) - h*f3 + F;
            u(2,i+1) = u(2,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);
        
            % j = J
            f1 = (u(1,i) - u(J-2,i))*u(J-1,i) - u(J,i) + F;
            f2 = (u(1,i) - u(J-2,i))*(u(J-1,i) + h/2*f1) - u(J,i) - h/2*f1 + F;
            f3 = (u(1,i) - u(J-2,i))*(u(J-1,i) + h/2*f2) - u(J,i) - h/2*f2 + F;
            f4 = (u(1,i) - u(J-2,i))*(u(J-1,i) + h*f3) - u(J,i) - h*f3 + F;
            u(J,i+1) = u(J,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);

            % now do the same for the perturbed matrix
            % j = 1
            f1 = (v(2,i) - v(J-1,i))*v(J,i) - v(1,i) + F;
            f2 = (v(2,i) - v(J-1,i))*(v(J,i) + h/2*f1) - v(1,i) - h/2*f1 + F;
            f3 = (v(2,i) - v(J-1,i))*(v(J,i) + h/2*f2) - v(1,i) - h/2*f2 + F;
            f4 = (v(2,i) - v(J-1,i))*(v(J,i) + h*f3) - v(1,i) - h*f3 + F;
            v(1,i+1) = v(1,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);
    
            % j = 2
            f1 = (v(3,i) - v(J,i))*v(1,i) - v(2,i) + F;
            f2 = (v(3,i) - v(J,i))*(v(1,i) + h/2*f1) - v(2,i) - h/2*f1 + F;
            f3 = (v(3,i) - v(J,i))*(v(1,i) + h/2*f2) - v(2,i) - h/2*f2 + F;
            f4 = (v(3,i) - v(J,i))*(v(1,i) + h*f3) - v(2,i) - h*f3 + F;
            v(2,i+1) = v(2,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);
        
            % j = J
            f1 = (v(1,i) - v(J-2,i))*v(J-1,i) - v(J,i) + F;
            f2 = (v(1,i) - v(J-2,i))*(v(J-1,i) + h/2*f1) - v(J,i) - h/2*f1 + F;
            f3 = (v(1,i) - v(J-2,i))*(v(J-1,i) + h/2*f2) - v(J,i) - h/2*f2 + F;
            f4 = (v(1,i) - v(J-2,i))*(v(J-1,i) + h*f3) - v(J,i) - h*f3 + F;
            v(J,i+1) = v(J,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);
           

            % iterate for the rest
            for j = 3:J-1
                f1 = (u(j+1,i) - u(j-2,i))*u(j-1,i) - u(j,i) + F;
                f2 = (u(j+1,i) - u(j-2,i))*(u(j-1,i) + h/2*f1) - u(j,i) - h/2*f1 + F;
                f3 = (u(j+1,i) - u(j-2,i))*(u(j-1,i) + h/2*f2) - u(j,i) - h/2*f2 + F;
                f4 = (u(j+1,i) - u(j-2,i))*(u(j-1,i) + h*f3) - u(j,i) - h*f3 + F;
                u(j,i+1) = u(j,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);
                
                % perturbed matrix
                f1 = (v(j+1,i) - v(j-2,i))*v(j-1,i) - v(j,i) + F;
                f2 = (v(j+1,i) - v(j-2,i))*(v(j-1,i) + h/2*f1) - v(j,i) - h/2*f1 + F;
                f3 = (v(j+1,i) - v(j-2,i))*(v(j-1,i) + h/2*f2) - v(j,i) - h/2*f2 + F;
                f4 = (v(j+1,i) - v(j-2,i))*(v(j-1,i) + h*f3) - v(j,i) - h*f3 + F;
                v(j,i+1) = v(j,i) + h/6*(f1 + 2*f2 + 2*f3 + f4);
            end
        end

    case 'euler'
        % Perform Forward Euler to iterate in time
        for i = 1:steps
            t(i+1) = i*h;
            disp(t(i+1))

            % iterate special cases first
            u(1,i+1) = u(1,i) + h*((u(2,i) - u(J-1,i))*u(J,i) - u(1,i) + F);
            u(2,i+1) = u(2,i) + h*((u(3,i) - u(J,i))*u(1,i) - u(2,i) + F);
            u(J,i+1) = u(J,i) + h*((u(1,i) - u(J-2,i))*u(J-1,i) - u(J,i) + F);

            % iterate special cases in perturbed matrix
            v(1,i+1) = v(1,i) + h*((v(2,i) - v(J-1,i))*v(J,i) - v(1,i) + F);
            v(2,i+1) = v(2,i) + h*((v(3,i) - v(J,i))*v(1,i) - v(2,i) + F);
            v(J,i+1) = v(J,i) + h*((v(1,i) - v(J-2,i))*v(J-1,i) - v(J,i) + F);

            % iterate the rest
            for j = 3:J-1
                u(j,i+1) = u(j,i) + h*((u(j+1,i) - u(j-2,i))*u(j-1,i) - u(j,i) + F);
                
                % perturbed matrix
                v(j,i+1) = v(j,i) + h*((v(j+1,i) - v(j-2,i))*v(j-1,i) - v(j,i) + F);
            end
        end
end

save u.txt u -ASCII
save v.txt v -ASCII

for i = 1:length(u)
    u2(i) = mean(u(:,i));
end

for i = 1:length(v)
    v2(i) = mean(v(:,i));
end

% Solutions
figure(1)
subplot(2,3,1); plot(t,u(1,:),t,v(1,:))
title('Solutions at Location 1')
xlabel('time')
legend('orig.','pert.')
subplot(2,3,2); plot(t,u(2,:),t,v(2,:))
title('Solutions at Location 2')
xlabel('time')
legend('orig.','pert.')
subplot(2,3,3); plot(t,u(3,:),t,v(3,:))
title('Solutions at Location 3')
xlabel('time')
legend('orig.','pert.')
subplot(2,3,4); plot(t,u(4,:),t,v(4,:))
title('Solutions at Location 4')
xlabel('time')
legend('orig.','pert.')
subplot(2,3,5); plot(t,u(5,:),t,v(5,:))
title('Solutions at Location 5')
xlabel('time')
legend('orig.','pert.')
subplot(2,3,6); plot(t,u(6,:),t,v(6,:))
title('Difference at Location 6')
xlabel('time')
legend('orig.','pert.')


% histograms
[n1u,xout1u] = hist(u(1,:));
[n2u,xout2u] = hist(u(2,:));
[n3u,xout3u] = hist(u(3,:));
[n4u,xout4u] = hist(u(4,:));
[n5u,xout5u] = hist(u(5,:));
[n6u,xout6u] = hist(u(6,:));
%[nu,xoutu] = hist(u2);
[n1v,xout1v] = hist(v(1,:));
[n2v,xout2v] = hist(v(2,:));
[n3v,xout3v] = hist(v(3,:));
[n4v,xout4v] = hist(v(4,:));
[n5v,xout5v] = hist(v(5,:));
[n6v,xout6v] = hist(v(6,:));
%[nv,xoutv] = hist(v2);

figure(2)
subplot(2,3,1); bar(xout1u,n1u/(J*(steps+1)),1,'b')
hold on;
bar(xout1v,n1v/(J*(steps+1)),.5,'r')
hold off;
xlim([-20 20])
title('Location 1')
legend('orig.','pert.')

subplot(2,3,2); bar(xout2u,n2u/(J*(steps+1)),1,'b')
hold on;
bar(xout2v,n2v/(J*(steps+1)),.5,'r')
hold off;
xlim([-20 20])
title('Location 2')
legend('orig.','pert.')

subplot(2,3,3); bar(xout3u,n3u/(J*(steps+1)),1,'b')
hold on;
bar(xout3v,n3v/(J*(steps+1)),.5,'r')
hold off;
xlim([-20 20])
title('Location 3')
legend('orig.','pert.')

subplot(2,3,4); bar(xout4u,n4u/(J*(steps+1)),1,'b')
hold on;
bar(xout4v,n4v/(J*(steps+1)),.5,'r')
hold off;
xlim([-20 20])
title('Location 4')
legend('orig.','pert.')

subplot(2,3,5); bar(xout5u,n5u/(J*(steps+1)),1,'b')
hold on;
bar(xout5v,n5v/(J*(steps+1)),.5,'r')
hold off;
xlim([-20 20])
title('Location 5')
legend('orig.','pert.')

subplot(2,3,6); bar(xout6u,n6u/(J*(steps+1)),1,'b')
hold on;
bar(xout6v,n6v/(J*(steps+1)),.5,'r')
hold off;
xlim([-20 20])
title('Location 6')
legend('orig.','pert.')

%subplot(2,3,6); bar(xoutu,nu/(J*(steps+1)),1,'b')
%hold on;
%bar(xoutv,nv/(J*(steps+1)),.5,'r')
%hold off;
%xlim([-20 20])
%title('Average')
%legend('orig.','pert.')

% Differences
figure(3)
subplot(2,3,1); plot(t,u(1,:) - v(1,:))
title('Difference at Location 1')
xlabel('time')
subplot(2,3,2); plot(t,u(2,:) - v(2,:))
title('Difference at Location 2')
xlabel('time')
subplot(2,3,3); plot(t,u(3,:) - v(3,:))
title('Difference at Location 3')
xlabel('time')
subplot(2,3,4); plot(t,u(4,:) - v(4,:))
title('Difference at Location 4')
xlabel('time')
subplot(2,3,5); plot(t,u(5,:) - v(5,:))
title('Difference at Location 5')
xlabel('time')
subplot(2,3,6); plot(t,u(6,:) - v(6,:))
title('Difference at Location 6')
xlabel('time')

% make movie of solution
figure(4)
lor_mov = avifile('lorenz_movie.avi','quality',100,'fps',10);
k = 1;
for i = 1:400:length(u)
    plot(t(1:i),u(1,1:i),t(1:i),v(1,1:i),'LineWidth',2)
    xlim([0 20])
    ylim([-15 15])
    title('Solutions at Location 1')
    xlabel('time')
    legend('orig.','pert.')

    M(k) = getframe(gcf);
    lor_mov = addframe(lor_mov,M(k));
    k = k + 1;
end

lor_mov = close(lor_mov);

print -f1 -djpeg 'solns' -r500
print -f2 -djpeg 'hists' -r500
print -f3 -djpeg 'diffs' -r500

disp('Done printing')
