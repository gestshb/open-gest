{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit vente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LR_Class, LR_DBSet, Forms, Controls,
  Graphics, Dialogs, StdCtrls, FileCtrl, ExtDlgs, EditBtn, Buttons, ExtCtrls,
  DBGrids, ActnList, StdActns, dm, DbCtrls, Menus, Grids,infoso,parm,findpro,ntolettre;

type

  { TFvente }

  TFvente = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Button5: TButton;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    Datasource3: TDatasource;
    Datasource4: TDatasource;
    Datasource5: TDatasource;
    Datasource6: TDatasource;
    Datasource7: TDatasource;
    DateEdit2: TDateEdit;
    DBEcdPRO: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBHT: TDBEdit;
    DBHT1: TDBEdit;
    DBTVA1: TDBEdit;
    DBunite: TDBEdit;
    Edit1: TEdit;
    Edit11: TEdit;
    Edit18: TEdit;
    Edit9: TEdit;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    id_op: TDBText;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    DBTVA: TDBEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MenuItem1: TMenuItem;
    Panel1: TPanel;
    supprimer: TMenuItem;
    PopupMenu1: TPopupMenu;
    RM: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Edit10Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure frReport1BeginBand(Band: TfrBand);
    procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
    procedure MenuItem1Click(Sender: TObject);



    procedure supprimerClick(Sender: TObject);

  private
    { private declarations }
     alert1,alert2:Integer;
  public
    { public declarations }
    modeOPR:string;
    Modefier:Boolean;
    num_pc:string;

  end;
procedure alternativePRIX;
var
  Fvente: TFvente;
  //numPC:integer; //num_piece
  nfac:integer; //id_fac

   temp:TStrings;


implementation
uses home;

{$R *.lfm}

{ TFvente }
 procedure alternativePRIX;     //لتغير سعر الشراء إلى سعر البيع أو العكس
 begin
  if fvente.modeOPR = 'ac' then
  fvente.DBEdit3.DataField:='PRIX_ACHAT'
  else fvente.dbedit3.DataField:='PRIX_VENTE';
 end;


procedure TFvente.Button5Click(Sender: TObject);
begin
 Ffindpro.senderform:='vente';
 Ffindpro.ShowModal;
end;

procedure TFvente.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked = true then dbedit4.Enabled:=true else dbedit4.Enabled:=false;
end;


//=============================================================================================
procedure TFvente.BitBtn2Click(Sender: TObject);    //enregistrement
var IDF : string;
    DT :TDateTime;
    MP :string;
    RS : string;
    VR : string;
    obs:String;
    count:integer;
begin
   idf:=  edit9.text; dt:=dateedit2.date; mp:='نقدا';

   if rm.text <> '' then rs:= rm.Text else rs:='0' ;

 with datam.SQLsave do
      begin
       close;
       sql.text:='EXECUTE PROCEDURE UPDATE_FAC_TABLE_FINALE(:IDF,1, :DT,null, :RM, :MP,null,null)';
       Params.ParamByName('idf').Value:=nfac;
       Params.ParamByName('dt').Value:=dt;
       Params.ParamByName('rm').Value:=rs;
       Params.ParamByName('mp').Value:=mp;
       try ExecSQL except on e:exception do begin showmessage('إدخال غير صحيح '+'  '+e.message); exit; end; end;
      end;
      // =============    vérification si la facture contient des donnée
 with    datam.SQLsave do
         begin
          close;
          sql.text:='select count(*) cn from operations where id_fac = :idf';
          Params.ParamByName('idf').Value:=nfac;
          open;
          count:=FieldByName('cn').AsInteger;
          if count <> 0 then datam.SQLTransaction1.CommitRetaining else showmessage('لا بد أن تحنوي الفاتورة على بيانات');
         end;

 //=========================================================
  //================  affichage du calcule ht ,tva, TTC
      with datam.SQLcalcul do
            begin
             close;
             sql.text:='SELECT THT, TVA, ttc1,TTC, TIMBRE FROM CALCULE_FAC(:IDF, :REMIS, :TESTTIMBRE)';
             Params.ParamByName('idf').Value:=nfac;
            Params.ParamByName('remis').Value:=rs;
            Params.ParamByName('testtimbre').Value:='0';
            open;
            TNumericField(dbht1.DataSource.DataSet.FieldByName('TTC')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tva')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tht')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('ttc1')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('timbre')).DisplayFormat:='### ### ### ### ##0.00';
            end;
 end;

procedure TFvente.BitBtn1Click(Sender: TObject);  //nouveau
var MX:string;
begin
 fvente.Modefier:= false ;
  //ارجاع الجينيراتور إلى القيمية الفعلية للفواتير
   datam.SQLTransaction1.Rollback;
   try
   with datam.SQLShowVente do
        begin
        close;
        sql.Text:='select max(num_pc) as mx from facture_vente where mode_opr = :mdop';
        Params.ParamByName('mdop').Value:=fvente.modeOPR;
        open;
        MX:= FieldByName('mx').AsString;  if mx ='' then mx:='0';
        close;
        if modeOPR='vt' then sql.Text:='SET GENERATOR num_vente TO '+mx else
        if modeOPR='ac' then sql.Text:='SET GENERATOR num_achat TO '+mx ;

        ExecSQL;
        end;
  Fvente.FormShow(Sender);
  except
     on e:exception do exit;
  end;

end;

procedure TFvente.BitBtn3Click(Sender: TObject);
begin
  close;
  Form1.SpeedButton16Click(Sender);
end;
//imprission==============================================================
procedure TFvente.BitBtn4Click(Sender: TObject);
var i:integer;


begin
  with Finfoso.SQLinfo do
      begin

        close;
         sql.text:='select a.STATUS, a.CAPITAL, a.ACTIVITY, a.CF, a.NIS, a.NA, a.RC RC1, a.CB1, a.CB2,a.TEL, a.FAX, a.ADR';
         sql.Add('from company a');
         open;

        temp:=TStringList.create;
  //تعين بيانات التقرير
       for i:=0 to 11 do
           begin
           temp.Insert(i,Fields.Fields[i].AsString);
           end;
      end;
   temp.insert(12,NoToTxt(dbht1.DataSource.DataSet.FieldByName('TTC').AsCurrency,'دينار','سنت'));
   if modeOPR='vt' then
       begin
         if ComboBox1.ItemIndex=0 then
         frReport1.LoadFromFile('bon.lrf') else
         if ComboBox1.ItemIndex=1 then
         frReport1.LoadFromFile('bon_simple.lrf') else
         if ComboBox1.ItemIndex=2 then
         frReport1.LoadFromFile('bon_tiket.lrf');
       end
   else
   if modeOPR='ac' then
   frReport1.LoadFromFile('achat.lrf');


   if CheckBox3.Checked=true then
       frReport1.ShowReport
   else
       begin
         frReport1.PrepareReport;
         frReport1.PrintPreparedReport('1-9999',1);
       end;
   temp.Free;
end;


procedure TFvente.CheckBox3Change(Sender: TObject);
var
    tm:string;
    f:textfile;
begin
 tm:=GetUserDir+'.GestSHB'+DirectorySeparator+'ConfigImp';
 AssignFile(f,tm);
    rewrite(f);
    if CheckBox3.Checked=true then
         writeln(f,'true')
    else
         writeln(f,'false') ;
    writeln(f,inttostr(ComboBox1.ItemIndex));
    CloseFile(f);
end;

procedure TFvente.ComboBox1Change(Sender: TObject);
var
    tm:string;
    f:textfile;
begin
 tm:=GetUserDir+'.GestSHB'+DirectorySeparator+'ConfigImp';
 AssignFile(f,tm);
    rewrite(f);
    if CheckBox3.Checked=true then
         writeln(f,'true')
    else
         writeln(f,'false') ;
    writeln(f,inttostr(ComboBox1.ItemIndex));
    CloseFile(f);
end;







procedure TFvente.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  DBGrid1.Columns.Items[4].DisplayFormat:='0.00';
  DBGrid1.Columns.Items[5].DisplayFormat:='0.00';
  DBGrid1.Columns.Items[7].DisplayFormat:='0.00';
  DBGrid1.AlternateColor:=clSkyBlue;
  DBGrid1.Columns.Items[4].Width:=150;
  DBGrid1.Columns.Items[5].Width:=150;
  DBGrid1.Columns.Items[6].Width:=150;
  DBGrid1.Columns.Items[7].Width:=150;

end;





procedure TFvente.Edit10Change(Sender: TObject);
begin
 with datam.SQLShowClients do
  begin
  close;
  sql.Text:='select * from membres where membre <> ''REMETTRE_LES_STOCKS_A_ZERO''';
 ;
  try open; except on e:exception do begin showmessage('إدخال غير صحيح' + ' ' +e.Message);exit;end;end;
  end;
  with datam.SQLaddpro do
       begin
         close;
         sql.text:='SELECT sum(p.VERS)-sum(p.TTC) Solde FROM ETAT_CLIENT(:ID_M, :DATE1, :DATE2) p';
         Params.ParamByName('id_m').Value:=datam.SQLShowClients.FieldByName('id_m').AsInteger;
         Params.ParamByName('date1').Value:=EncodeDate(2012,01,01);
         Params.ParamByName('date2').Value:=now;
         open;
        end;
end;



procedure TFvente.Edit11Change(Sender: TObject);
begin
  datam.SQLShowpro.Close;
  datam.SQLShowpro.sql.Text:='select * from produits where 1=1';
  if edit11.text <> '' then datam.SQLShowpro.sql.Add('and id like '''+UpperCase(edit11.Text)+'%''' );
  datam.SQLShowpro.open;
  alternativePRIX;

end;

procedure TFvente.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var MX:string;
begin
  ComboBox1.Enabled:=false;
  //ارجاع الجينيراتور إلى القيمية الفعلية للفواتير
   datam.SQLTransaction1.Rollback;
   Form1.SpeedButton16Click(Sender);
   try
   with datam.SQLShowVente do
        begin
        close;
        sql.Text:='select max(num_pc) as mx from facture_vente where mode_opr = :mdop';
        Params.ParamByName('mdop').Value:=fvente.modeOPR;
        open;
        MX:= FieldByName('mx').AsString;
          if mx ='' then mx:='0';
        close;
        if modeOPR='vt' then sql.Text:='SET GENERATOR num_vente TO '+mx else
        if modeOPR='ac' then sql.Text:='SET GENERATOR num_achat TO '+mx ;
        ExecSQL;
        end;
   except
      on e:exception do exit;
   end;
end;











//=========================================================================================
procedure TFvente.FormShow(Sender: TObject); //en show form
var id_tva:byte;
    tm,check,combox:string;
    f:TextFile;


begin

 //options d'imprission===================================
 if modeOPR='vt' then
 begin
 ComboBox1.Enabled:=true;
 tm:=GetUserDir+'.GestSHB'+DirectorySeparator+'ConfigImp';
 AssignFile(f,tm);
 if FileExists(tm) then
   begin
    Reset(f);
    readln(f,check);
    readln(f,combox);
    CloseFile(f);
    if check = 'true' then CheckBox3.Checked:=true
    else CheckBox3.Checked:=false;
    ComboBox1.ItemIndex:=strTOint(combox);

   end;
 end ;
//=======================================================
  Edit11.SetFocus;
  Edit11.SelStart := 0;
  Button5.Height:=edit11.Height;
  RM.clear;
  edit18.clear;
  edit11.Clear;
  edit1.clear;
  datam.SQLTransaction1.Rollback;
 // DBGrid2.Clear;
  with datam do
       begin
        SQLcalcul.close;
        SQLsave.close;
        SQLShowClients.close;
        SQLShowPRO.close;
        SQLtest.close;
        SQLShowVente.close;
       end;
  //optenir les paramètre par défault d'alert de stock
  with datam.SQLShowVente do
       begin
        close;
        sql.text:='select * from PARAMETRES where id=3';
        open;
        alert1:=FieldByName('parm').AsInteger;
        alert2:=FieldByName('alert').AsInteger;
       end;
 if fvente.Modefier = false then
  begin
  //creation du clé primaire du facture_table
  edit18.text:='1';
  datam.SQLShowVente.close;
  datam.SQLShowVente.sql.Text:='SELECT IDF FROM INSERT_ID_FAC (:mdop)';
  datam.SQLShowVente.Params.ParamByName('mdop').Value:=fvente.modeOPR;
  datam.SQLShowVente.open;
  nfac:=datam.SQLShowVente.FieldByName('idf').AsInteger;

  with datam.SQLShowVente do
       begin
        close;
        sql.text:='select num_pc from facture_vente where mode_opr = :mdop and id_fac = :idf';
        Params.ParamByName('mdop').Value:=fvente.modeOPR;
        Params.ParamByName('idf').Value:=nfac;
        open;
        edit9.Text:='00'+FieldByName('num_pc').AsString;
        close;
       end;
  //تعيين الحال الافتراضي للطابع الضريبي والقيمة المضافة
  with FinfoSO.SQLinfo do
       begin
         close;
         sql.text:='SELECT ID,DESIGNATION,PARM FROM PARAMETRES';
         open;
         id_tva:=FieldByName('parm').AsInteger;
         if id_tva = 1 then CheckBox1.Checked:=true else CheckBox1.Checked:=false;
       end;

  end

 else //on modification
     begin
      //optenir le id_fac du piece modifier
      with datam.SQLShowVente do
           begin
            close;
            sql.text:='select id_fac,versement,remis,timbre,date_fac,mode_payment,client , observation from facture_vente where mode_opr=:mdop and num_pc=:num_pc';
            Params.ParamByName('mdop').Value:=fvente.modeOPR;
            Params.ParamByName('num_pc').Value:=fvente.num_pc;
            open;
            nfac:=FieldByName('id_fac').AsInteger;


            rm.Text:=FieldByName('remis').AsString;

            dateedit2.date:=FieldByName('date_fac').AsDateTime;

            edit9.Text:=fvente.num_pc;

            Fvente.Edit10Change(sender);
           end;
       datam.SQLShowVente.close;
         datam.SQLShowVente.sql.text:='SELECT N "الرقم",ID "المعرف",PRODUIT "المنتج",UN "الوحدة",PRIX "الثمن",QN "الكمية",TVA,HT FROM AFFICHER_IN_DBGRID(:nfac)';
         datam.SQLShowVente.Params.ParamByName('nfac').Value:=nfac;
         datam.SQLShowVente.open;

       //================  affichage du calcule ht ,tva, TTC

      with datam.SQLcalcul do
            begin
             close;
             sql.text:='SELECT THT, TVA, ttc1,TTC, TIMBRE FROM CALCULE_FAC(:IDF, :REMIS, :TESTTIMBRE)';
             Params.ParamByName('idf').Value:=nfac;
            Params.ParamByName('remis').Value:=rm.text;
            Params.ParamByName('testtimbre').Value:='0';
            open;
            TNumericField(dbht1.DataSource.DataSet.FieldByName('TTC')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tva')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tht')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('ttc1')).DisplayFormat:='### ### ### ### ##0.00';

            end;
     end;
     if CheckBox1.Checked = true then dbedit4.Enabled:=true else dbedit4.Enabled:=false;

  WindowState:=wsMaximized;
end;

procedure TFvente.frReport1BeginBand(Band: TfrBand);
var
  CurrentPage, TotalPages : Variant ;
  count:integer;

begin
  if (Band.Typ = btPageFooter) and frReport1.FinalPass then
  begin
  Band.Visible :=false;
  count:=DBGrid1.DataSource.DataSet.RecordCount;
   frReport1.GetVariableValue('PAGE#', CurrentPage );
   if (count <=24) and (CurrentPage=1) then Band.Visible :=true else
   if (count >24) and (count <=59) and (CurrentPage=2) then Band.Visible :=true else
   if  (count >59) and (count <=94) and (CurrentPage=3) then Band.Visible :=true else
   if  (count >94) and (count <=129) and (CurrentPage=4) then Band.Visible :=true else
   if  (count >129)  and (CurrentPage>=5) then Band.Visible :=true ;
  end;
end;

procedure TFvente.frReport1EnterRect(Memo: TStringList; View: TfrView);
var ms:TMemoryStream;

begin
 MS:= TMemoryStream.Create;
 with finfoso.SQLinfo do
       begin
         close;
         sql.text:='select logo from company';
         try
         open;
         TBlobField(FieldByName('logo')).saveToStream(MS);
         MS.Position:=0;
         if View.Name = 'Picture1' then TFrPictureView(View).Picture.LoadFromStream(ms);
         except on e:exception do begin exit;ms.free; end; end;
       end;
         ms.free;

end;

procedure TFvente.frReport1GetValue(const ParName: String; var ParValue: Variant
  );

begin




         if ParName = 'Status' then ParValue:= temp.Strings[0] else
         if ParName = 'activity' then ParValue:=temp.Strings[2] else
         if ParName = 'RC1' then ParValue:=temp.Strings[6] else
         if ParName = 'cf' then ParValue:=temp.Strings[3] else
         if ParName = 'cb' then ParValue:=temp.Strings[7] else
         if ParName = 'addr' then ParValue:=temp.Strings[11] else
         if ParName = 'capital' then ParValue:=temp.Strings[1] else
         if ParName = 'id_f' then ParValue:=edit9.Text else
         if ParName = 'tel' then ParValue:=temp.Strings[9] else
         if ParName = 'fax' then ParValue:=temp.Strings[10] else
         if ParName = 'ht' then ParValue:=dbht.text else
         if ParName = 'tva' then ParValue:=dbtva.text else
         if ParName = 'ttc' then ParValue:=dbtva1.Text else
         if ParName = 'client' then ParValue:=edit1.text else
         if ParName = 'remis' then ParValue:=rm.text else
         if ParName = 'net' then ParValue:=dbht1.text else

         if ParName = 'somme' then ParValue:=temp.Strings[12] else
         if ParName = 'dt' then ParValue:=dateedit2.Date;






end;

//==================================================================================================
procedure TFvente.MenuItem1Click(Sender: TObject);  //modification
begin
 DBEcdPRO.text:=DBGrid1.Datasource.DataSet.FieldByName('المعرف').AsString;
 edit11.Text:=DBGrid1.Datasource.DataSet.FieldByName('المعرف').AsString;
 edit18.text:=DBGrid1.Datasource.DataSet.FieldByName('الكمية').AsString;
  with datam.SQLtest do
       begin
         sql.Text:='delete from operations where produit = :id and id_fac = :idf';
        Params.ParamByName('idf').Value:=nfac;
        Params.ParamByName('id').Value:=edit11.Text;
        ExecSQL;
       end;
  with datam.SQLShowVente do
      begin
      close;
      open;
      end;
  with datam.SQLcalcul do
      begin
      close;
      open;
      TNumericField(dbht1.DataSource.DataSet.FieldByName('TTC')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tva')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tht')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('ttc1')).DisplayFormat:='### ### ### ### ##0.00';
      end;
  edit11.SetFocus;
  edit11.SelStart:=0;
end;


//==================================================================================================
procedure TFvente.supprimerClick(Sender: TObject);   //supprission d'un field from dbgrid1
var Value: string;
begin
  Value := DBGrid1.Datasource.DataSet.FieldByName('المعرف').AsString;
  with datam.SQLtest do
       begin
         sql.Text:='delete from operations where produit = :id and id_fac = :idf';
        Params.ParamByName('idf').Value:=nfac;
        Params.ParamByName('id').Value:=value;
        ExecSQL;
       end;
  with datam.SQLShowVente do
      begin
      close;
      open;
      end;
  with datam.SQLcalcul do
      begin
      close;
      open;
      TNumericField(dbht1.DataSource.DataSet.FieldByName('TTC')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tva')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tht')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('ttc1')).DisplayFormat:='### ### ### ### ##0.00';

      end;
end;


//===================================================================================================
procedure TFvente.BitBtn5Click(Sender: TObject);  // Ajouté a la facture
 var
    PR: string;
    QN : string;
    UN :string;
    prix : string;
    TVA : string;
    rs:string;
    stock:integer;
begin
  pr:=DBEcdPRO.text;
  un:= DBunite.Text;
  prix:=dbedit3.text;
  if rm.text <> '' then rs:= rm.Text else rs:='0' ;
  qn:=edit18.Text;

  //vérifier si le tva exonereé
 if CheckBox1.Checked=true then tva:=dbedit4.Text else tva:='0';
  //alert de stock ********************************
 if modeOPR='vt' then
  if edit11.text <> '' then
   if alert1=1 then
    begin
     with datam.SQLalert do
      begin
       close;
       sql.Text:='SELECT round(QU) q FROM VIEW_STOK (:ID_PRO)';
       Params.ParamByName('id_pro').Value:=UpperCase(DBEcdPRO.text);
       open;
       stock:=FieldByName('q').Asinteger;
      end;
      if stock <= alert2 then
        if MessageDlg(' قد بلغ مخزون هذا المنتج الحد الأدنى ... هل تريد المتابعة ؟',mtWarning,[mbYes,mbNo],0)= mrNo then
           begin
               edit11.Clear;dbedit2.Clear;dbedit3.Clear;dbedit4.Clear;edit18.clear;
               Edit11.SetFocus;
               Edit11.SelStart := 0;
               exit;
           end;
    end;
  //************************************************
 with datam.SQLShowVente do
       begin
         close;
         sql.text:='EXECUTE PROCEDURE ADDOPEARION( :IDF, :PR, :QN, :UN, :prix, :TVA)';
         with Params do
              begin
                ParamByName('idf').Value:=nfac;
                ParamByName('PR').Value:=PR;
                ParamByName('QN').Value:=QN;
                ParamByName('UN').Value:=UN;
                ParamByName('prix').Value:=prix;
                ParamByName('TVA').Value:=tva;
              end;
          try ExecSQL; except on e:exception do
          begin
          showmessage('إدخال غير صحيح ');
           edit11.Clear;dbedit2.Clear;dbedit3.Clear;dbedit4.Clear;edit18.clear;
          //déplacement de pointeur vers edit11
           Edit11.SetFocus;
           Edit11.SelStart := 0;
          end;
          end;

       end;
       //================  affichage dans DBgrid
       datam.SQLShowVente.close;
       datam.SQLShowVente.sql.text:='SELECT N "الرقم",ID "المعرف",PRODUIT "المنتج",UN "الوحدة",PRIX "الثمن",QN "الكمية",TVA,HT FROM AFFICHER_IN_DBGRID(:nfac)';
         datam.SQLShowVente.Params.ParamByName('nfac').Value:=nfac;
         datam.SQLShowVente.open;
         DBGrid1.AlternateColor:=clSkyBlue;
       //================  affichage du calcule ht ,tva, TTC

       with datam.SQLcalcul do
            begin
             close;
             sql.text:='SELECT THT, TVA, ttc1,TTC, TIMBRE FROM CALCULE_FAC(:IDF, :REMIS, :TESTTIMBRE)';
             Params.ParamByName('idf').Value:=nfac;
            Params.ParamByName('remis').Value:=rs;
            Params.ParamByName('testtimbre').Value:='0';
            open;
            TNumericField(dbht1.DataSource.DataSet.FieldByName('TTC')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tva')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('tht')).DisplayFormat:='### ### ### ### ##0.00';
            TNumericField(dbht1.DataSource.DataSet.FieldByName('ttc1')).DisplayFormat:='### ### ### ### ##0.00';
            end;

 edit11.Clear;
 dbedit2.Clear;
 dbedit3.Clear;
 dbedit4.Clear;
 edit18.text:='1';
 //déplacement de pointeur vers edit11
 Edit11.SetFocus;
 Edit11.SelStart := 0;

end;














end.

