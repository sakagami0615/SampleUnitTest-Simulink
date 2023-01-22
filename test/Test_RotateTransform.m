% テストハーネスモデルも設定関係
model = 'TestHarness_RotateTransform';
fixedStep = 0.1;

% テスト信号作成
srcXsData = [];
thetaData = [];
answerData = [];

srcXsData = cat(3, srcXsData, [1, 0; 0, 1]);
thetaData = cat(1, thetaData, 0);
answerData = cat(3, answerData, [1, 0; 0, 1]);

srcXsData = cat(3, srcXsData, [1, 0; 0, 1]);
thetaData = cat(1, thetaData, 0);
answerData = cat(3, answerData, [1, 0; 0, 1]);

% TimeSeries信号作成し、baseワークスペースに割り当て
stopTime = (size(thetaData, 1) - 1) * fixedStep;
time = (0:fixedStep:stopTime)';
testInput_srcXs = timeseries(srcXsData, time);
testInput_theta = timeseries(thetaData, time);
assignin('base','testInput_srcXs', testInput_srcXs);
assignin('base','testInput_theta', testInput_theta);

% モデルオープン
load_system(model);

% Sim時間設定
set_param(model, 'Solver','FixedStepAuto', 'FixedStep',string(fixedStep), 'StopTime',string(stopTime));
save_system(model);

% Sim実施
sim(model);

% モデルクローズ
close_system(model);

% テスト結果確認
for i = 1:length(time)
    assert(sum(testOutput_rotXs.Data(:,:,i) ~= answerData(:,:,i), 'all') == 0);
end
