{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit apropos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls,lclintf;

type

  { TFapropos }

  TFapropos = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Fapropos: TFapropos;

implementation

{$R *.lfm}

{ TFapropos }

procedure TFapropos.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFapropos.Label9Click(Sender: TObject);
begin
  OpenURL('http://www.shbsoft.blogspot.com/');
end;

end.

