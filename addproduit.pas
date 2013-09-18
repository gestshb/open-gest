{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit addproduit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, DbCtrls, Buttons,dm,db;

type

  { TFaddproduit }

  TFaddproduit = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    quantite: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    referance: TEdit;
    produit: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    unite: TEdit;
    tva: TEdit;
    Achat: TEdit;
    Vente: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    modif:Boolean;
  end; 

var
  Faddproduit: TFaddproduit;

implementation
uses stok;


{$R *.lfm}

{ TFaddproduit }

procedure TFaddproduit.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TFaddproduit.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin

  referance.Enabled:=true;
  Produit.Clear;
  Unite.Clear;
  TVA.Clear;
  Vente.Clear;
  Achat.Clear;
  modif:=false;
end;

procedure TFaddproduit.FormCreate(Sender: TObject);
begin
  modif:=false;
end;

procedure TFaddproduit.FormShow(Sender: TObject);     //en show form
begin
  SpeedButton1.Height:=ComboBox1.Height;
  SpeedButton2.Height:=ComboBox1.Height;
  ComboBox1.Clear;
  with datam.SQLaddpro2 do
       begin
           close;
           sql.Text:='select groups from groups';
           open;
           while not EOF do
               begin

                   ComboBox1.Items.Add(FieldByName('groups').AsString);
                   next;
               end;
       end;

  if modif=false then begin ComboBox1.ItemIndex:=0; Faddproduit.Caption:='منتج جديد' end
  else
     begin
     Faddproduit.Caption:='تعديل';
     ComboBox1.ItemIndex:=Faddproduit.ComboBox1.Items.IndexOf(fstok.DBGrid1.DataSource.DataSet.FieldByName('المجموعة').AsString);
     end;

end;

procedure TFaddproduit.SpeedButton1Click(Sender: TObject);  //إضافة مجموعة جديدة
begin
  with datam.SQLaddpro2 do
       begin
           close;
           sql.text:='insert into groups values (null,:papa)';
           Params.ParamByName('papa').Value:=UpperCase( InputBox('مجموعة جديدة','أضف مجموعة جديدة ',' '));
           ExecSQL;
           datam.SQLTransaction1.CommitRetaining;
       end;
  Faddproduit.FormShow(Sender);
end;

procedure TFaddproduit.SpeedButton2Click(Sender: TObject);  //حذف مجموعة
var index:integer;
begin
  index:=ComboBox1.ItemIndex;
  if index>=0 then
  with datam.SQLaddpro2 do
       begin
           close;
           sql.text:='delete from groups where groups= :papa and groups <> ''عام''';
           Params.ParamByName('papa').Value:=ComboBox1.Items.Strings[index];
           ExecSQL;
           datam.SQLTransaction1.CommitRetaining;
       end;
  Faddproduit.FormShow(Sender);
end;

procedure TFaddproduit.BitBtn1Click(Sender: TObject);
var
  s:string;
begin

  if  (produit.text='') or (referance.text='')  then begin showmessage('أحد الحقول الرئيسة فارغ إما حقل المعرف أو حقل اسم المنتج');exit; end;
  //set defaut valeur
  if vente.Text='' then vente.Text:='0';
  if achat.text='' then achat.text:='0';
  if tva.Text='' then tva.Text:='0';
  if unite.Text='' then unite.Text:='و';
if modif=false then                         //إضافة جديدة
  begin
  with datam.SQLaddpro2 do
       begin
           close;
           sql.Text:='execute procedure addpro :s,:produit,:unite,:vt,:ch,:c ,:gr';
           Params.ParamByName('produit').Value:=UpperCase(produit.text);
           Params.ParamByName('unite').Value:=unite.text;
           Params.ParamByName('s').Value:=UpperCase(referance.text);
           Params.ParamByName('c').Value:=tva.Text;
           Params.ParamByName('vt').Value:=vente.Text;
           Params.ParamByName('ch').Value:=achat.text;
           Params.ParamByName('gr').Value:=ComboBox1.Items.Strings[ComboBox1.ItemIndex];
           try ExecSQL; except on e:exception do  showmessage('إدخال غير صحيح' + ' ' +e.Message) end;
       end;
  DataM.SQLTransaction1.CommitRetaining;

  Produit.Clear;
  Unite.Clear;
  TVA.Clear;
  Vente.Clear;
  Achat.Clear;
  end
 else                             //تعديل
   begin
  with datam.SQLaddpro2 do
       begin
           close;
           sql.Text:='update produits set nom_produit=:produit,unite=:unite,prix_vente=:vt,prix_achat=:ch,tva=:c , groups=:gr where id=:s';
           Params.ParamByName('produit').Value:=UpperCase(produit.text);
           Params.ParamByName('unite').Value:=unite.text;
           Params.ParamByName('s').Value:=UpperCase(referance.text);
           Params.ParamByName('c').Value:=tva.Text;
           Params.ParamByName('vt').Value:=vente.Text;
           Params.ParamByName('ch').Value:=achat.text;
           Params.ParamByName('gr').Value:=ComboBox1.Items.Strings[ComboBox1.ItemIndex];
           try ExecSQL; except on e:exception do  showmessage('إدخال غير صحيح' + ' ' +e.Message) end;;
       end;
  DataM.SQLTransaction1.CommitRetaining;

  Produit.Clear;
  Unite.Clear;
  TVA.Clear;
  Vente.Clear;
  Achat.Clear;
  modif:=false;
  Faddproduit.close;
  end  ;
  //quantite initiale
  try
  if quantite.text <> '' then
    begin
      with datam.SQLaddpro2 do
         begin
         close;
         sql.text:='EXECUTE PROCEDURE REMETTRE_LES_STOCKS_A_ZERO(:id_pro,:qt)';
         Params.ParamByName('id_pro').Value:=UpperCase(referance.text);
         Params.ParamByName('qt').Value:=quantite.text;
        ExecSQL;
         datam.SQLTransaction1.CommitRetaining;
         end;
    end;

   except
    on e:exception do showmessage('إدخال غير صحيح' + ' ' +e.Message);
   end;
   quantite.clear;
   Referance.Clear;

end;

end.

