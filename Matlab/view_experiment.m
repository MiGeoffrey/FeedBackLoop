%% exp viewer

clear ax

f = figure('units','normalized','outerposition',[0 0 1 1]);
ax(1) = subplot(411); hold on; title('ellipse moment'); xlabel('time(s)'); ylabel('ellipse moment');
ax(2) = subplot(412); hold on; title('tail speed'); xlabel('time(s)'); ylabel('tail speed');
ax(3) = subplot(413); hold on; title('vestibular stimulus'); xlabel('time(s)'); ylabel('motor angle');
ax(4) = subplot(414); hold on; title('visual stimulus'); xlabel('time(s)'); ylabel('theta');


load([recordpath 'protocol']);

for i=1:repetitions
    for j=1:size(protocol, 1)
        exp = protocol{j,1};                                        % type of experiment (static, retrOMR ...)
        path = [recordpath int2str(i) '-' int2str(j) '-' exp];      % full path of file plus name. ex : D:\Hugo\2017-xx\1-3-static
        expViewer(exp, path, f);                                    % expViewer( exp, path, f )
    end
end

linkaxes(ax, 'x');

