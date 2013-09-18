{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit parm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, SynEdit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, EditBtn, Spin,infoSo,dm;

type

  { TFparam }

  TFparam = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    CheckGroup1: TCheckGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioGroup1: TRadioGroup;
    SpinEdit1: TSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure parametrage;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Fparam: TFparam;


implementation

{$R *.lfm}

{ TFparam }
procedure TFparam.parametrage;
var  tva,timbre,alert1:byte;
   alert2:integer;
   F:textfile;
  chemain,tm,isAuto,time:String;
begin
 with FinfoSO.SQLinfo do
      begin
        close;
        sql.text:='SELECT ID,DESIGNATION,PARM,alert FROM PARAMETRES';
        open;
        if IsEmpty then
           begin
             if RadioButton1.Checked then tva:=1 else tva:=0;

             if CheckBox1.Checked then alert1:=1 else timbre:=0;
             alert2:=SpinEdit1.Value;
             close;
             sql.text:='insert into parametres values (1,''tva'',:tva,null);';
             Params.ParamByName('tva').Value:=tva;
             ExecSQL;
             close;
             sql.text:='insert into parametres values (2,''timbre'',:timbre,null);';
             Params.ParamByName('timbre').Value:=timbre;
             ExecSQL;
             sql.text:='insert into parametres values (3,''alert'',:alert1,:alert2);';
             Params.ParamByName('alert1').Value:=alert1;
             Params.ParamByName('alert2').Value:=alert2;
             ExecSQL;
             datam.SQLTransaction1.CommitRetaining;
           end
        else
             begin
                if FieldByName('id').asinteger =1 then
                   if FieldByName('parm').asinteger=1 then RadioButton1.Checked:=true
                   else RadioButton2.Checked:=true;
                next;
                next;
                if FieldByName('id').asinteger=3 then
                   begin
                     if FieldByName('parm').asinteger=1 then CheckBox1.Checked:=true
                     else
                       if FieldByName('parm').asinteger=0 then CheckBox1.Checked:=false;
                     SpinEdit1.Value:=FieldByName('alert').asinteger;
                   end;
             end;
        end;


end;

procedure TFparam.FormShow(Sender: TObject);
var i:integer;
begin

 parametrage;
end;

procedure TFparam.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFparam.BitBtn2Click(Sender: TObject);

var tva,timbre,alert1:byte; alert2:integer;
   F:textfile;
  chemain,tm,isAuto,time:String;
begin
            with FinfoSO.SQLinfo do
             begin
              if RadioButton1.Checked then tva:=1 else tva:=0;

              if CheckBox1.Checked then alert1:=1 else timbre:=0;
              alert2:=SpinEdit1.Value;
              close;
              sql.text:='update parametres set parm=:tva where id=1';
              Params.ParamByName('tva').Value:=tva;
              ExecSQL;
              close;
              sql.text:='update parametres set parm=:timbre where id=2';
              Params.ParamByName('timbre').Value:=timbre;
              ExecSQL;
              close;
              sql.text:='update parametres set parm=:alert1,alert=:alert2 where id=3';
              Params.ParamByName('alert1').Value:=alert1;
              Params.ParamByName('alert2').Value:=alert2;
              ExecSQL;
              close;
              datam.SQLTransaction1.CommitRetaining;
             end;
            close;
end;







end.

