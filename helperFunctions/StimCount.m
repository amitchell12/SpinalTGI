function StimCount(scr, vars)
%% Stimulation count down
% A G Mitchell - 07.03.2022
% Last edited - 08.03.2022
% 
% small function that counts down x number of seconds (defined in
% VAS_loadParams.m) before another screen is presented

% Other functions needed:

%vars.control.devFlag  = 1; % Development flag 1. Set to 1 when developing the task, will optimize stim size for laptop, not hide cursor
%VAS_loadParams;

% Set text size, dependent on screen resolution
if any(logical(scr.winRect(:)>3000))       % 4K resolution
    scr.TextSize = 65;
else
    scr.TextSize = vars.instructions.textSize;
    scr.numSize = vars.waitStim.textSize;
end

% getting screen frame-rate
scr.nominalFrameRate = Screen('NominalFrameRate', scr.win);
% note: this is a very rudimentary counter that counts down from N -> 0
% seconds, can make this more fancy by displaying time & combining
% GetSecs() with frame-rate
presSecs = [sort(repmat(1:vars.waitStim.secs, 1, scr.nominalFrameRate), 'descend') 0]; % number of seconds you want to count down from

% presenting screen loop
for s_idx = 1:length(presSecs)
    Screen('TextSize', scr.win, scr.TextSize);
    DrawFormattedText(scr.win, vars.waitStim.text, 'center', (scr.yCenter-200), scr.TextColour);
    numberString = num2str(presSecs(s_idx));

    % Draw the countdown number to the screen
    Screen('TextSize', scr.win, scr.numSize);
    DrawFormattedText(scr.win, numberString, scr.xCenter, scr.yCenter, scr.TextColour);

    [~, ~] = Screen('Flip', scr.win); 
end

end