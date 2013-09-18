{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit infoSO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, ExtDlgs, DbCtrls,db,dm;

type

  { TFinfoSO }

  TFinfoSO = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Datasource1: TDatasource;
    DBImage1: TDBImage;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl1: TPageControl;
    SQLinfo: TSQLQuery;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { private declarations }
    status:Boolean;
  public
    { public declarations }
  end;

var
  FinfoSO: TFinfoSO;

implementation

{$R *.lfm}

{ TFinfoSO }



procedure TFinfoSO.BitBtn1Click(Sender: TObject);
begin
 try
 if OpenPictureDialog1.Execute then Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);

  with SQLinfo do
       begin
         close;
         sql.text:='select *  from company';
         open;
       end;
 if not SQLinfo.IsEmpty then
     with SQLinfo do
     begin
       close;
       sql.text:='update company set logo = :image';
       Params.ParamByName('image').LoadFromFile (OpenPictureDialog1.FileName,ftblob);
       ExecSQL;
     end
 else
      with SQLinfo do
     begin
       close;
       sql.text:='insert into  company(logo) values(:image)';
       Params.ParamByName('image').LoadFromFile (OpenPictureDialog1.FileName,ftblob);
       ExecSQL;
     end   ;
 datam.SQLTransaction1.CommitRetaining;
 except
 on e:exception do exit; end;


end;

procedure TFinfoSO.BitBtn3Click(Sender: TObject);


begin


  with SQLinfo do
       begin
         if status = false then
             begin
               close;
               sql.text:='INSERT INTO COMPANY (ID, STATUS, CAPITAL, ACTIVITY, CF, NIS, NA, RC, CB1, CB2,TEL, FAX, ADR)';
               sql.Add('VALUES (1,:STATUS,:CAPITAL,:ACTIVITY,:CF,:NIS,:NA,:RC,:CB1,:CB2,:TEL,:FAX,:ADR)');
               Params.ParamByName('STATUS').Value:=edit1.Text;
               Params.ParamByName('CAPITAL').Value:=edit2.Text;
               Params.ParamByName('ACTIVITY').Value:=edit3.Text;
               Params.ParamByName('CF').Value:=edit4.Text;
               Params.ParamByName('NIS').Value:=edit5.Text;
               Params.ParamByName('NA').Value:=edit6.Text;
               Params.ParamByName('RC').Value:=edit7.Text;
               Params.ParamByName('CB1').Value:=edit8.Text;
               Params.ParamByName('CB2').Value:=edit9.Text;
               Params.ParamByName('TEL').Value:=edit10.Text;
               Params.ParamByName('FAX').Value:=edit11.Text;
               Params.ParamByName('ADR').Value:=edit12.Text;
               ExecSQL;
             end
         else
             begin
               close;
               sql.text:='update COMPANY set STATUS=:STATUS, CAPITAL=:CAPITAL, ';
               sql.Add('ACTIVITY=:ACTIVITY, CF=:CF, NIS=:NIS, NA=:NA, RC=:RC, CB1=:CB1, CB2=:CB2,TEL=:TEL, FAX=:FAX, ADR=:ADR');
               Params.ParamByName('STATUS').Value:=edit1.Text;
               Params.ParamByName('CAPITAL').Value:=edit2.Text;
               Params.ParamByName('ACTIVITY').Value:=edit3.Text;
               Params.ParamByName('CF').Value:=edit4.Text;
               Params.ParamByName('NIS').Value:=edit5.Text;
               Params.ParamByName('NA').Value:=edit6.Text;
               Params.ParamByName('RC').Value:=edit7.Text;
               Params.ParamByName('CB1').Value:=edit8.Text;
               Params.ParamByName('CB2').Value:=edit9.Text;
               Params.ParamByName('TEL').Value:=edit10.Text;
               Params.ParamByName('FAX').Value:=edit11.Text;
               Params.ParamByName('ADR').Value:=edit12.Text;
               ExecSQL;
             end;
       end;
  datam.SQLTransaction1.CommitRetaining;
end;

procedure TFinfoSO.BitBtn4Click(Sender: TObject);
begin
 try
  with SQLinfo do
     begin
       close;
       sql.text:='update company set logo = null';
       ExecSQL;
     end   ;
 datam.SQLTransaction1.CommitRetaining;
 except
 on e:exception do exit; end;
 Image1.Picture:=Nil;
end;

procedure TFinfoSO.FormShow(Sender: TObject);
 var ms:TMemoryStream;
 procedure recuperer(text,caption:string;var edit:Tedit);
     begin

     edit.text:=text;
     end;

begin
 with SQLinfo do
      begin
        close;
         sql.text:='select STATUS, CAPITAL, ACTIVITY, CF, NIS, NA, RC, CB1, CB2,TEL, FAX, ADR from company';
         open;
         if sqlinfo.IsEmpty then status:=false
         else
           begin
           status:=true;
            recuperer(FieldByName('STATUS').asstring,'<Société ex : SARL AHMED>',edit1);
            recuperer(FieldByName('CAPITAL').asstring,'<Capital>',edit2);
            recuperer(FieldByName('ACTIVITY').asstring,'<Activity>',edit3);
            recuperer(FieldByName('CF').asstring,'<code Fiscal>',edit4);
            recuperer(FieldByName('NIS').asstring,'<NIS>',edit5);
            recuperer(FieldByName('NA').asstring,'<numéro d''article>',edit6);
            recuperer(FieldByName('RC').asstring,'<RC>',edit7);
            recuperer(FieldByName('CB1').asstring,'<Compte Bancaire 1>',edit8);
            recuperer(FieldByName('CB2').asstring,'<Compte Bancaire 2>',edit9);
            recuperer(FieldByName('TEL').asstring,'<Tel>',edit10);
            recuperer(FieldByName('FAX').asstring,'<Fax>',edit11);
            recuperer(FieldByName('ADR').asstring,'<Adresse>',edit12);
           end;
      end;


 try
  MS:= TMemoryStream.Create;
  with SQLinfo do
       begin
         close;
         sql.text:='select logo from company';
         try
         open;
         TBlobField(FieldByName('logo')).saveToStream(MS);
         MS.Position:=0;
         Image1.Picture.LoadFromStream(ms);
         except on e:exception do begin exit;ms.free; end; end;
       end;
         Finally
         ms.free;
         end;



end;

end.

