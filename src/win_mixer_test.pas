program win_mixer_test;

uses
  {$ifdef unix}
  cthreads,
  cmem, {$endif}
  SysUtils,
  CTypes,
  win_mixer;

var
  volleft, volright: integer;
  
 procedure ACallback;
  begin
   writeln('Yep, this is the callback, mixer-elem has changed...');
   writeln('New Volume left = ' + IntToStr(wm_MasterVolLeft) + '/100');
   writeln('New Volume right = ' + IntToStr(wm_MasterVolRight) + '/100');
   if wm_MasterMuted then
   writeln('New State Muted = true')
   else writeln('New State Muted = false');
   end;

begin

  writeln();
  writeln('Begin session.');
  writeln();
  
  volleft  := WINmixerGetVolume(0);
  volright := WINmixerGetVolume(1);

  writeln('Original Volume left = ' + IntToStr(volleft) + '/100');
  writeln('Original Volume right = ' + IntToStr(volright) + '/100');
  writeln();
  
  sleep(300);
 
  WINmixerSetVolume(0, 25);
  WINmixerSetVolume(1, 55);

  writeln('New Volume left = ' + IntToStr(WINmixerGetVolume(0)) + '/100');
  writeln('New Volume right = ' + IntToStr(WinmixerGetVolume(1)) + '/100');

  sleep(500);

  writeln();
 
  WINmixerSetVolume(0, volleft);
  WINmixerSetVolume(1, volright);
   
  writeln('Back to original Volume left = ' + IntToStr(WINmixerGetVolume(0)) + '/100');
  writeln('Back to original Volume right = ' + IntToStr(WINmixerGetVolume(1)) + '/100');
  
  writeln();
  
  writeln('Change volume from mixer-system to fire the callback...'); 
  writeln('Press a key to quit.');
  
  WinMixerSetCallBack(@ACallback); 

  readln;
  
  WINmixerFreeCallback();
  
  writeln('Bye bye...');

end.

