{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit start;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  home,connect;

type

  { Tfstart }

  Tfstart = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);

  private

    { private declarations }
  public
    { public declarations }
  end; 

var
  fstart: Tfstart;i:integer;


implementation

{$R *.lfm}

{ Tfstart }


procedure Tfstart.Timer1Timer(Sender: TObject);
var i:integer;
begin
  if timer1.Interval=1000 then
  begin
    for i:=1 to 100000000 do ;
    fstart.Hide;
    form1.Show;
    Timer1.Enabled:=false;
  end;
end;







end.

