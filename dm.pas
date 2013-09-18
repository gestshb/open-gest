{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
unit dm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, IBConnection, FileUtil;

type

  { TDataM }

  TDataM = class(TDataModule)
    IBConnection1: TIBConnection;
    SQLcaisse: TSQLQuery;
    SQLcaisse1: TSQLQuery;
    SQLcopier: TSQLQuery;
    SQLproduit: TSQLQuery;
    SQLaddpro: TSQLQuery;
    SQLmembre: TSQLQuery;
    SQLAddMembre: TSQLQuery;
    SQLcalcul: TSQLQuery;
    SQLhome: TSQLQuery;
    SQLfrais: TSQLQuery;
    SQLchiffre: TSQLQuery;
    SQLaddpro2: TSQLQuery;
    SQLalert: TSQLQuery;
    SQLshowPro2: TSQLQuery;
    SQLsave: TSQLQuery;
    SQLtest: TSQLQuery;
    SQLShowVente: TSQLQuery;
    SQLShowClients: TSQLQuery;
    SQLShowPRO: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  DataM: TDataM;

implementation

{$R *.lfm}

end.

