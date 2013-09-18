{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit connect;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons,dm,parm;

type

  { TFconnect }

  TFconnect = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
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
  Fconnect: TFconnect;

implementation
uses home,stok,vente,NToLettre;

{$R *.lfm}

{ TFconnect }

procedure TFconnect.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit1.Text:=OpenDialog1.FileName;
end;



procedure TFconnect.FormShow(Sender: TObject);
 var  Fh:textfile;
   st,tm,host:String;

 begin
    if not DirectoryExists(GetUserDir+'.GestSHB') then
    mkdir(GetUserDir+'.GestSHB');
    tm:=GetUserDir+'.GestSHB'+DirectorySeparator+'ConfigConnection';
    AssignFile(fh,tm);
    if FileExists(tm) then
    begin
    Reset(fh);
    readln(fh,st);
    readln(fh,host);
    edit1.text:=st;
    edit4.text:=host;
    CloseFile(fh);
    end;
  Button1.Height:=edit1.Height;
end;



procedure TFconnect.BitBtn1Click(Sender: TObject);
 var  Fh:textfile;
  st,tm,user_p,RL,us,host:String;
  h_r,h_w,mb_r,mb_w,pr_r,pr_w,p_r,p_w:byte;

begin

      datam.IBConnection1.CLOSE;
      us:=edit2.text;
      if pos('dbprimaire',edit1.text) > 0 then exit;
      try
      datam.IBConnection1.DatabaseName:=edit1.text;
      datam.IBConnection1.UserName:=edit2.Text;
      datam.IBConnection1.Password:=edit3.text;
      datam.IBConnection1.HostName:=Edit4.text;
      if datam.IBConnection1.HostName='' then begin datam.IBConnection1.HostName:='localhost';edit4.Text:='localhost';end;
      //calcule(us,rl);
      datam.IBConnection1.Role:=RL;
      datam.IBConnection1.Connected:=true;
      Except
      on e:exception do begin showmessage('إدخال غير صحيح' + ' ' +e.Message); exit;end;
      end;
      if not datam.IBConnection1.Connected =true then exit;
      Fparam.parametrage;
      //creation d'un fichier de historique
      //******************************** //
      tm:=GetUserDir+'.GestSHB'+DirectorySeparator+'ConfigConnection';   //
      AssignFile(fh,tm);                 //
      Rewrite(fh);                       //
      st:=edit1.text;                    //
      writeln(fh,st);                    //
       host:=edit4.text;                 //
       writeln(fh,host);                 //
       CloseFile(fh);                    //
       //********************************
      {بعد تثبيت سيرفر فايربارد قم بإضافة نفسك إلى مجموعة فايربارد بالامر
      sudo adduser `id -un` firebird}
      edit3.Clear;
      close;
      Form1.Formshow(Sender);
      //تفعيل الكائنات غير المفعلة

      if UpperCase(edit2.text)='SYSDBA' then
        begin
         with Form1 do //home
           begin

             SpeedButton1.Enabled:=true;
             SpeedButton2.Enabled:=true;
             SpeedButton21.Enabled:=true;
             SpeedButton6.Enabled:=true;
             SpeedButton7.Enabled:=true;
             SpeedButton12.Enabled:=true;
             SpeedButton13.Enabled:=true;
             SpeedButton16.Enabled:=true;
             SpeedButton7.Enabled:=true;
             SpeedButton20.Enabled:=true;
             SpeedButton14.Enabled:=true;
             ComboBox1.Enabled:=true;
              MenuItem2.Enabled:=true;
              MenuItem18.Enabled:=true;
              MenuItem31.Enabled:=true;
              MenuItem14.Enabled:=true;

           end;
          with fstok do
            begin
               SpeedButton1.Enabled:=true;
               SpeedButton3.Enabled:=true;
               MenuItem1.Enabled:=true;
            end;
          with Fvente do
            begin
               BitBtn2.Enabled:=true;
               BitBtn5.Enabled:=true;
               MenuItem1.Enabled:=true;
            end;
        end;

end;

procedure TFconnect.BitBtn2Click(Sender: TObject);
begin
  close;
end;

end.

