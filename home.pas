{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit home;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, Forms, Controls, Graphics,
  Dialogs, Menus, ExtCtrls, Buttons, StdCtrls, ComCtrls, EditBtn, ExtDlgs,
  DBGrids, DbCtrls, create, connect, stok, dm, vente, db, sqldb, Grids,
  process,infoso,parm,apropos,lclintf;

type

  { TForm1 }

  TForm1 = class(TForm)
    host: TLabel;
    ComboBox1: TComboBox;
    Datasource1: TDatasource;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DBCheckBox1: TDBCheckBox;
    DBGrid1: TDBGrid;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    BD: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    typeo: TLabel;
    MenuItem14: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem7: TMenuItem;
    SpeedButton14: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    volume: TLabel;
    USER: TLabel;
    nb: TLabel;
    nb_pr: TLabel;
    nb_pr2: TLabel;
    nb_vt: TLabel;
    nb_ac: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem8: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    ToolBar2: TToolBar;
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);

  private
    { private declarations }
    y,q:Array[1 .. 10] of string;
    ahmed:integer;
  public
    { public declarations }
  count:integer;
  end; 

var
  Form1: TForm1; rootID:string;
procedure affichage (num:integer;mdop,caption1,type_piece,membre:string;date1,date2:TDateTime);


implementation

{$R *.lfm}

{ TForm1 }
//=================================================================================

//procedure d'affichage
procedure affichage (num:integer;mdop,caption1,type_piece,membre:string;date1,date2:TDateTime);
begin
  with datam.SQLhome do
       begin
         close;
         sql.text:='SELECT NUM "الرقم",DATE_FAC "التاريخ",TIME_FAC "الوقت", VERSEMENT "الإيداع",REMIS "تخفيض",MODE_PAYMENT "طريقة الإيداع",TTC "المجموع العام", UTILISATEUR "المستخدم"'  ;
         sql.Add('FROM SP_FACTURE_VENTE(:NUM, :Mdop, :DATE1, :DATE2)');
         sql.Add('where client <> ''REMETTRE_LES_STOCKS_A_ZERO''');
         Params.ParamByName('num').Value:=num;
         Params.ParamByName('mdop').Value:=mdop;
         Params.ParamByName('date1').Value:=date1;
         Params.ParamByName('date2').Value:=date2;
         open;

       end;
  fvente.modeOPR:=mdop;
  Form1.Caption:='OpenGest 1.2';
  form1.typeo.Caption:=caption1;
  fvente.label10.caption:=type_piece+'  رقم  ' ;


  if fvente.Modefier=false then
     fvente.Caption:='نموذج جديد';

end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  Fapropos.Show;
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);  //modification
var x:string ;
begin
  x:=fvente.modeOPR;
  fvente.num_pc:=form1.DBGrid1.DataSource.DataSet.FieldByName('الرقم').AsString;
  if fvente.num_pc <> '' then
  begin
  fvente.Modefier:=true;
  fvente.show;
  if x='vt' then affichage(0,'vt','المبيعات','وصل','زبون',dateedit1.date,dateedit2.date)else
 if x='ac' then affichage(0,'ac','المشتريات','وصل','مورد',dateedit1.date,dateedit2.date);
  //==================================//
  if x='vt' then fvente.Caption:='تعديل للوصل رقم  '+fvente.num_pc;
 if x='ac' then fvente.Caption:='تعديل للوصل رقم  '+fvente.num_pc;

  end;

end;

procedure TForm1.SpeedButton13Click(Sender: TObject); //supression
var id_fac,x:string;
begin
  fvente.num_pc:=form1.DBGrid1.DataSource.DataSet.FieldByName('الرقم').AsString;
  if fvente.num_pc <> '' then
  begin
 if MessageDlg('هل أنت متأكد ؟',mtConfirmation,[mbYes,mbNo],0)= mrYes then
 begin
 x:=fvente.modeOPR;
  with datam.SQLShowvente do
           begin
            close;
            sql.text:='EXECUTE PROCEDURE DELETE_PIECE(:MDOP, :NUM_PC)';
            Params.ParamByName('num_pc').Value:=fvente.num_pc;
            Params.ParamByName('mdop').Value:=fvente.modeOPR;
            ExecSQL;
           end;
 datam.SQLTransaction1.CommitRetaining;
 if x='vt' then affichage(0,'vt','المبيعات','وصل','زبون',dateedit1.date,dateedit2.date)else
 if x='ac' then affichage(0,'ac','المشتريات','وصل','مورد',dateedit1.date,dateedit2.date);
end;
end;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
var x:string;
begin
  x:=fvente.modeOPR;
  if x='vt' then affichage(0,'vt','المبيعات','وصل','زبون',dateedit1.date,dateedit2.date)else
 if x='ac' then affichage(0,'ac','المشتريات','وصل','مورد',dateedit1.date,dateedit2.date);
end;



procedure TForm1.SpeedButton16Click(Sender: TObject);
 var x:string;
begin
  x:=fvente.modeOPR;
 if x='vt' then affichage(0,'vt','المبيعات','وصل','زبون',dateedit1.date,dateedit2.date)else
 if x='ac' then affichage(0,'ac','المشتريات','وصل','مورد',dateedit1.date,dateedit2.date);
end;







procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 Panel2.Visible:=true;
affichage(0,'vt','المبيعات','وصل','زبون',dateedit1.date,dateedit2.date);
end;

procedure TForm1.SpeedButton20Click(Sender: TObject);
begin
  frReport1.LoadFromFile('home.lrf');
    frReport1.ShowReport;
end;

procedure TForm1.SpeedButton21Click(Sender: TObject);
begin
   Panel2.Visible:=false;
   typeo.caption:='';
   Form1.Formshow(Sender);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin

 Panel2.Visible:=true;
 affichage(0,'ac','المشتريات','وصل','مورد',dateedit1.date,dateedit2.date);
end;



procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
fconnect.Show;
end;



procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  fstok.Show;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var x:string;
begin
  fvente.Modefier:=false;
  x:=fvente.modeOPR;
  fvente.show;
  if x='vt' then affichage(0,'vt','المبيعات','وصل','زبون',dateedit1.date,dateedit2.date)else
 if x='ac' then affichage(0,'ac','المشتريات','وصل','مورد',dateedit1.date,dateedit2.date);
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
 Var Processus : TProcess;
begin
Processus := TProcess.Create(Nil);
Processus.CommandLine := 'opengest';
Processus.Execute;
Application.Terminate;

end;



procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  fcreate.Show;

end;



procedure TForm1.MenuItem31Click(Sender: TObject);
begin
  finfoSo.show;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Fconnect.Show;
end;




procedure TForm1.MenuItem18Click(Sender: TObject);   //REMETTRE_LES_STOCKS_A_ZERO
begin
 if MessageDlg('بعد هذه العملية لا يمكنك الرجوع إلى الحالة السابقة ...هل تريد المتابعة ؟',mtConfirmation,[mbYes,mbNo],0)= mrYes then
    with datam.SQLcopier do
         begin
         close;
         sql.text:='EXECUTE PROCEDURE REMETTRE_LES_STOCKS_A_ZERO(:id_pro,:qt)';
         Params.ParamByName('id_pro').Value:='null';
         Params.ParamByName('qt').Value:=0;
         ExecSQL;
         datam.SQLTransaction1.CommitRetaining;
         end;

end;



procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  DBGrid1.Columns.Items[4].DisplayFormat:='0.00';
  DBGrid1.Columns.Items[3].DisplayFormat:='0.00';
  DBGrid1.Columns.Items[6].DisplayFormat:='0.00';
  DBGrid1.Columns.Items[1].DisplayFormat:='dd/mm/yyyy';

  form1.DBGrid1.AlternateColor:=clSkyBlue;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;




procedure TForm1.ComboBox1Change(Sender: TObject);
var filtre:string;
begin

if ComboBox1.ItemIndex <> 1 then filtre:=InputBox('الفلترة','ادخل رقم الوصل ',' ');
  with datam.SQLhome do
       begin
         close;
         sql.text:='SELECT NUM "الرقم",DATE_FAC "التاريخ",TIME_FAC "الوقت", VERSEMENT "الإيداع",REMIS "تخفيض",MODE_PAYMENT "طريقة الإيداع",TTC "المجموع العام", UTILISATEUR "المستخدم"'  ;
         sql.Add('FROM SP_FACTURE_VENTE(:NUM, :Mdop, :DATE1, :DATE2)');
         sql.Add('where client <> ''REMETTRE_LES_STOCKS_A_ZERO''');
         if ComboBox1.ItemIndex=0 then sql.Add('and num like ''%'+filtre+'%''') ;
         Params.ParamByName('num').Value:=0;
         Params.ParamByName('mdop').Value:=Fvente.modeOPR;
         Params.ParamByName('date1').Value:=dateedit1.date;
         Params.ParamByName('date2').Value:=dateedit2.date;
         open;

       end;

end;



procedure TForm1.FormShow(Sender: TObject);
     var
         x:byte;


     vr:string;
     tm:string;
begin
//======================================maximiz
if WindowState <> wsMaximized  then
   begin
   Height := Screen.Height;
   Width := Screen.Width;
   Top := 0;
   Left := 0;
   WindowState:=wsMaximized;
 end;
//=======================================

//اختبار الاتصال
 //=============
 try datam.IBConnection1.Connected:=true except on e:exception do begin  exit; end;end;
 //==============
                                           OpenURL('http://www.shbsoft.blogspot.com/');



  with datam.SQLhome do
       begin
        close;
        sql.text:='SELECT NB_VT,NB_AC,NB_DV,NB_BC,NB_MBR,NB_PR,NB_PR2,INFO,CURRENT_USER USR,db_size FROM EN_DEMARAGE';
        open;
        NB_VT.Caption:=FieldByName('NB_VT').AsString;
        NB_AC.Caption:=FieldByName('NB_AC').AsString;


        NB_PR.Caption:=FieldByName('NB_PR').AsString;
        NB_PR2.Caption:=FieldByName('NB_PR2').AsString;
        volume.Caption:=FieldByName('db_size').AsString+' Mo';
        IF DATAM.IBConnection1.HostName <> '' THEN HOST.Caption:=DATAM.IBConnection1.HostName ELSE HOST.Caption:='local host';
        BD.Caption:=DATAM.IBConnection1.DatabaseName;
        USER.Caption:=FieldByName('USR').AsString;
        x:=FieldByName('INFO').AsInteger;
        if x=1 then datam.SQLTransaction1.CommitRetaining;
       end;
       DateEdit1.Date :=IncMonth(DateEdit2.Date,-1);
end;



procedure TForm1.frReport1GetValue(const ParName: String; var ParValue: Variant
  );
begin
 if fvente.modeOPR='vt' then
  begin if ParName='membre' then parvalue:='المبيعات'; end
 else
 if fvente.modeOPR='ac' then
  begin if ParName='membre' then parvalue:='المشتريات'; end;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  fparam.show;
end;

























end.

