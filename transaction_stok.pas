{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit transaction_stok;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, LR_Class, LR_DBSet, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, EditBtn, StdCtrls, DBGrids, Buttons, DbCtrls, Grids;

type

  { Tftrans }

  Tftrans = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn5: TBitBtn;
    Datasource1: TDatasource;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DBGrid1: TDBGrid;
    DBText1: TDBText;
    DBText2: TDBText;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    SpeedButton14: TSpeedButton;
    SQLtrans: TSQLQuery;


    procedure BitBtn5Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

    procedure FormShow(Sender: TObject);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
    procedure SpeedButton14Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
    id_pr:string;
    qu:real;
  end; 

var
  ftrans: Tftrans;

implementation

{$R *.lfm}

{ Tftrans }

procedure Tftrans.FormShow(Sender: TObject);
begin
  DateEdit1.Date :=IncMonth(DateEdit2.Date,-1);
  qu:=DBtext2.DataSource.DataSet.FieldByName('qu').AsFloat;
  if qu > 0 then dbtext2.Font.color:=clGreen else  dbtext2.font.Color:=clRed;
  with SQLtrans do
       begin
         close;

         sql.text:='SELECT NUM_PC "الرقم", MDOP "نوع العملية", PRIX  "الثمن",    ENTRER "الداخل", SORTIE "الخارج", STOK "المخزون", DT "التاريخ", TM "الوقت" ';
         sql.add('FROM TRANSACTION_STOK(:id,:date1, :DATE2)');
         Params.ParamByName('id').Value:=id_pr;
         Params.ParamByName('date1').Value:=dateedit1.date;
         Params.ParamByName('date2').Value:=dateedit2.date;
         open;
       end;
       DBGrid1.AlternateColor:=clSkyBlue;
       WindowState:=wsMaximized;
end;

procedure Tftrans.frReport1GetValue(const ParName: String; var ParValue: Variant
  );
begin
  if ParName='produit' then ParValue:=DBText1.Caption else
    if ParName='stock' then ParValue:=DBText2.caption;
end;

procedure Tftrans.BitBtn5Click(Sender: TObject);
begin
  frReport1.LoadFromFile('mouvement.lrf');
  frReport1.ShowReport;
end;

procedure Tftrans.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  DBGrid1.Columns.Items[2].DisplayFormat:='0.00';
  DBGrid1.AlternateColor:=clSkyBlue;
  DBGrid1.Columns.Items[2].Width:=100;
end;



procedure Tftrans.SpeedButton14Click(Sender: TObject);
begin
  with SQLtrans do
       begin
         close;
         Params.ParamByName('id').Value:=id_pr;
         Params.ParamByName('date1').Value:=dateedit1.date;
         Params.ParamByName('date2').Value:=dateedit2.date;
         open;
       end;
      DBGrid1.AlternateColor:=clInfoBk;
end;



end.

