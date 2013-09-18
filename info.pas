{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit info;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { Tfinfo }

  Tfinfo = class(TForm)
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure BitBtn2Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  finfo: Tfinfo;

implementation

{$R *.lfm}

{ Tfinfo }

procedure Tfinfo.BitBtn2Click(Sender: TObject);
begin
  close;
end;



end.

