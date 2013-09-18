{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY. /gestshb@gmail.com                        //
=========================================================//
}

unit findpro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, Buttons;

type

  { TFfindpro }

  TFfindpro = class(TForm)
    BitBtn1: TBitBtn;
    Datasource2: TDatasource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    SQLfindpro: TSQLQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    senderform:string;
  end;

var
  Ffindpro: TFfindpro;

implementation
uses vente;

{$R *.lfm}

{ TFfindpro }

procedure TFfindpro.Edit1Change(Sender: TObject);
begin
   with SQLfindpro do
   begin
    Close;
    sql.Text:='select * from produits where 1=1';
    if edit1.text <> '' then sql.Add('and id like '''+UpperCase(edit1.Text)+'%''' );
    open;
   end;
end;

procedure TFfindpro.BitBtn1Click(Sender: TObject);
begin
  if senderform='vente' then
  with fvente do
   begin
    Edit11.text :=ffindpro.DBGrid1.DataSource.DataSet.FieldByName('id').AsString;
    edit18.SetFocus;
    edit18.SelStart:=0;
   end
  else

  edit1.clear;
  edit2.Clear;
  close;
end;


procedure TFfindpro.Edit2Change(Sender: TObject);
begin
  with SQLfindpro do
   begin
    Close;
    sql.Text:='select * from produits where 1=1';
    if edit2.text <> '' then sql.Add('and nom_produit like ''%'+UpperCase(edit2.Text)+'%''' );
    open;
   end;
end;

procedure TFfindpro.FormShow(Sender: TObject);
begin
  with SQLfindpro do
   begin
    Close;
    sql.Text:='select * from produits';
    open;
   end;
end;

end.

