{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.   gestshb@gmail.com                     //
=========================================================//
}
unit create;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, EditBtn, FileCtrl,info;

type

  { TFcreate }

  TFcreate = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SETDR: TSelectDirectoryDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Fcreate: TFcreate;

implementation
uses connect;

{$R *.lfm}

{ TFcreate }

procedure TFcreate.Button1Click(Sender: TObject);
begin
  if setdr.Execute then edit2.Text:=setdr.FileName;
end;

procedure TFcreate.FormShow(Sender: TObject);
begin
  Button1.Height:=edit2.Height;
end;

procedure TFcreate.BitBtn1Click(Sender: TObject);

begin
  close;
end;

procedure TFcreate.BitBtn2Click(Sender: TObject);
var
  F:textfile;
  chemain,tm,isAuto,time:String;

 begin
    if not DirectoryExists(GetUserDir+'.GestSHB') then
    mkdir(GetUserDir+'.GestSHB');
    tm:=GetUserDir+'.GestSHB'+DirectorySeparator+'chemain';
    AssignFile(f,tm);
    chemain:= edit2.text;
    isAuto:='1';
    Time:='10';
    if not FileExists(tm) then
    begin
    rewrite(f);
    writeln(f,chemain);
    writeln(f,isAuto);
    writeln(f,Time);
    CloseFile(f);
    end;


    tm:=edit2.Text+DirectorySeparator+edit1.text;
       if not FileExists(tm) then
       begin
       CopyFile('dbprimaire.fdb',tm);
       finfo.Label5.Caption:='chown firebird:firebird '+tm;
       {$IFDEF Linux}
       finfo.ShowModal;
       {$ENDIF}
       {$IFDEF windows}
       showmessage('تم إنشاء قاعدة البيانات بنجاح');
       {$ENDIF}

       Fcreate.close;
       end
       else showmessage('الملف موجود');

end;

end.

