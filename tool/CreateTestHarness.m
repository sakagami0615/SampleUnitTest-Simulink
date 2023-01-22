
% テストハーネス作成の流れは下記の通り
% ※作成途中
% --------------------------------------------------
% 1. テスト対象のサブシステムのパスを取得(主導してい or gsb)
%    パスがサブシステムでないときの処理も忘れずに
%    ※基本はReferenceSubsystemが対象になる
%
% 2. モデルの保存先を指定する(ダイアログ) 
% 
% 3. サブシステム内のInportとOutportの情報を取得
%    ※信号名を取得して、テストハーネスの入力信号名に使用と思ったけど、
%　　　名前を付けずにTestinput_1みたいに与えた方が楽そうなので、個数がわかれば良さそう
%
% 4. ハーネスモデルを作成する
%    ※指定したサブシステムのコピー、入出力信号用のFrom/To Workspaceの配置、
%　　　入力信号のキャストの処理を実施する
% 
% 5. ハーネスモデルを保存する
% --------------------------------------------------

% ブロック情報取得
srcBlockPath = gsb;
srcBlockType = get_param(srcBlockPath, 'BlockType');
srcBlockName = get_param(srcBlockPath, 'Name');

% 入出力ポートのパス取得
srcBlockInportPaths = find_system(srcBlockPath, 'SearchDepth',1, 'BlockType','Inport');
srcBlockOutportPaths = find_system(srcBlockPath, 'SearchDepth',1, 'BlockType','Outport');

% 入出力ポートの名前取得
srcBlockInportNames = cellfun(@(x) get_param(x, 'Name'), srcBlockInportPaths, 'UniformOutput',false);
srcBlockOutportNames = cellfun(@(x) get_param(x, 'Name'), srcBlockOutportPaths, 'UniformOutput',false);

% ハーネスモデル名を指定
testBlockName = strcat('TestHarness_', srcBlockName);

% ハーネスモデルを新規作成
new_system(testBlockName);
open_system(testBlockName);

% TODO: ブロック追加処理
add_block('simulink/Signal Attributes/Data Type Conversion', testBlockName + "/cast");
%add_block(srcBlockPath, testBlockName + "/cast");
%Simulink.SubSystem.copyContentsToBlockDiagram(srcBlockPath, testBlockName);
%add_block('srcBlockPath',testBlockName + "/Subsystem");

% TODO: 保存処理

% TODO: ハーネスモデルクローズ
%close_system(testBlockName);
