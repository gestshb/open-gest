{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit stok;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, DbCtrls, DBGrids, dm, db,
  sqldb, addproduit, transaction_stok, Grids, Menus;

type

  { Tfstok }

  Tfstok = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    DBGrid1: TDBGrid;
    Edit2: TEdit;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem1: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SpeedButton1: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SQLQuery1: TSQLQuery;
    ToolBar1: TToolBar;

    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);

    procedure ComboBox2Change(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
  private
    { private declarations }
  item:string;
  public
    { public declarations }

  end; 

var
  fstok: Tfstok;

implementation

{$R *.lfm}

{ Tfstok }

procedure Tfstok.SpeedButton2Click(Sender: TObject);
begin
  Panel1.Visible:=true;
end;

procedure Tfstok.SpeedButton3Click(Sender: TObject);
begin
  Faddproduit.modif:=true;

  with Faddproduit do
     with DBGrid1.DataSource.DataSet do
        begin
        referance.Enabled:=false;
         referance.text:=FieldByName('المعرف').AsString;
          produit.text:=FieldByName('المنتج').AsString;
          unite.text:=FieldByName('الوحدة').AsString;
          tva.text:=FieldByName('tva').AsString;
          Achat.text:=FieldByName('ثمن الشراء').AsString;
          Vente.text:=FieldByName('ثمن البيع').AsString;

          Show;
        end;

end;







procedure Tfstok.SpeedButton6Click(Sender: TObject);
begin
  //transaction du stok
       ftrans.id_pr:=DBGrid1.DataSource.DataSet.FieldByName('المعرف').AsString;
       with datam.SQLshowPro2 do
            begin
       close;
       sql.Text:='SELECT nom_PRODUIT,QU' ;
       sql.add('FROM VIEW_STOK(:id_pro) where id=:id ');
       Params.ParamByName('id').Value:=ftrans.id_pr;
       Params.ParamByName('id_pro').Value:='allproduits';
       open;
       ftrans.ShowModal;

            end;


end;

procedure Tfstok.SpeedButton9Click(Sender: TObject);
begin
  DataM.SQLproduit.close;
  DataM.SQLproduit.OPEN;

end;





procedure Tfstok.BitBtn4Click(Sender: TObject);
begin
  frReport1.LoadFromFile('stock.lrf');
  frReport1.ShowReport;
end;

procedure Tfstok.BitBtn5Click(Sender: TObject);
var
  s:Currency;
begin
  showmessage('تأكد أن أيا من المنتجات ليست كميته سلبية ولا ثمن شرائه يساوي الصفر');
  with SQLQuery1 do
     begin
       close;
       sql.text:='select sum(cast (PR_AC as numeric(18,2))*QU) "somme" from view_stok(:id_pro)';
       Params.ParamByName('id_pro').Value:='allproduits';
       open;
       s:=FieldByName('somme').AsFloat;
       showmessage(Format('%.2n',[s]));
     end;
end;

procedure Tfstok.ComboBox2Change(Sender: TObject);
begin
 if fstok.ComboBox2.ItemIndex = 0 then fstok.item:='nom_produit'
 else
  if fstok.ComboBox2.ItemIndex = 2 then fstok.item:='groups'
  else fstok.item:='qu';
   DataM.SQLproduit.close;
  datam.SQLproduit.sql.Text:='SELECT ID "المعرف",nom_PRODUIT "المنتج",UN "الوحدة", PR_VT "ثمن البيع", PR_AC "ثمن الشراء",TVA,groups "المجموعة",QU "الكمية",cast (PR_AC as numeric(18,2))*QU "القيمة"' ;
  datam.SQLproduit.sql.add('FROM VIEW_STOK(:id_pro)');
   datam.SQLproduit.sql.add('order by '+item);
   datam.SQLproduit.Params.ParamByName('id_pro').Value:='allproduits';
  datam.SQLproduit.open;
end;



procedure Tfstok.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  DBGrid1.Columns.Items[3].DisplayFormat:='0.00';
  DBGrid1.Columns.Items[4].DisplayFormat:='0.00';
  DBGrid1.Columns.Items[8].DisplayFormat:='0.00';
  DBGrid1.AlternateColor:=clSkyBlue;
  DBGrid1.Columns.Items[3].Width:=150;
  DBGrid1.Columns.Items[4].Width:=150;
  DBGrid1.Columns.Items[5].Width:=150;
  If gdSelected In State Then
  Begin

    TDBGrid(Sender).Canvas.Brush.Color := clNavy
  End Else
  Begin

    If TDBGrid(Sender).DataSource.DataSet.FieldByName('الكمية').Value <= 0 Then

      TDBGrid(Sender).Canvas.font.Color := clred
    //Else
     // TDBGrid(Sender).Canvas.font.Color := clWhite;
  End;
  // On applique les modifications.
  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);
end;



procedure Tfstok.FormShow(Sender: TObject);   //en show form
begin
  if fstok.ComboBox2.ItemIndex = 0 then fstok.item:='nom_produit'
  else fstok.item:='QU';
   DataM.SQLproduit.close;
  datam.SQLproduit.sql.Text:='SELECT ID "المعرف",nom_PRODUIT "المنتج",UN "الوحدة", PR_VT "ثمن البيع", PR_AC "ثمن الشراء",TVA,groups "المجموعة",QU "الكمية",cast (PR_AC as numeric(18,2))*QU "القيمة"' ;
  datam.SQLproduit.sql.add('FROM VIEW_STOK(:id_pro)');
   datam.SQLproduit.sql.add('order by '+item);
   datam.SQLproduit.Params.ParamByName('id_pro').Value:='allproduits';
   datam.SQLproduit.open;
end;

procedure Tfstok.MenuItem1Click(Sender: TObject);     //supprission
var rf:string;
begin
 rf:=DBGrid1.DataSource.DataSet.FieldByName('المعرف').AsString;
 with datam.SQLaddpro do
    begin
      close;
      sql.Text:='delete from produits where id=:rf';
      Params.ParamByName('rf').Value:=rf;

       try
         ExecSQL;
       except
       on e:exception do showmessage('لا يمكنك حذف المنتج لأنه مرتبط ببيانات أخرى');end;
  end;
 datam.SQLTransaction1.CommitRetaining;
 DataM.SQLproduit.close;
  DataM.SQLproduit.OPEN;

end;

procedure Tfstok.SpeedButton14Click(Sender: TObject);
var i:Byte;
begin
  DataM.SQLproduit.close;
   for i:=5 downto 2 do if datam.SQLproduit.sql.Count > i then datam.SQLproduit.sql.Delete(i);
  if ComboBox1.ItemIndex=0 then
      if trim(edit2.Text) <> '' then
     datam.SQLproduit.sql.Add(' where nom_produit like ''%'+trim(uppercase(Edit2.text))+'%''');
  if ComboBox1.ItemIndex=1 then
      if trim(edit2.Text) <> '' then
     datam.SQLproduit.sql.Add(' where id like '''+trim(UpperCase(Edit2.text))+'%''');
  if ComboBox1.ItemIndex=2 then
      if trim(edit2.Text) <> '' then
     datam.SQLproduit.sql.Add(' where groups like ''%'+trim(UpperCase(Edit2.text))+'%''');
  datam.SQLproduit.sql.Add('order by '+item);
  datam.SQLproduit.open;
end;

procedure Tfstok.SpeedButton1Click(Sender: TObject);
begin

  faddproduit.Show;
end;

end.

