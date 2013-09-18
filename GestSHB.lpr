{  ======================================================//
Written and copyright 2013 ahmed sohbi abu abd elbarr    //
Distributed under the GNU General Public License.        //
This code comes with NO WARRANTY.                        //
=========================================================//
}
program GestSHB;

{$mode objfpc}{$H+}

uses
  {$DEFINE UseCThreads}  //زيادة لتشغيل thread
   {$IFDEF UNIX}{$IFDEF UseCThreads}
   cthreads,
   {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, home, create, connect, start, dm, info, stok, addproduit,
   vente, transaction_stok,  sysutils,
   infoSO, NToLettre,
  parm,  apropos,  findpro, dynlibs;



   const
  {$IFDEF Unix}
{$DEFINE extdecl:=cdecl}
    fbclib = 'libfbclient.' + sharedsuffix;
{$ENDIF}
{$IFDEF Windows}
  {$DEFINE extdecl:=stdcall}
   fbclib = 'fbclient.dll';
   seclib = 'gds32.dll';
   thirdlib = 'fbembed.dll';
{$ENDIF}

{$R *.res}

var

  IBaseLibraryHandle : TLibHandle;

begin
  Application.Initialize;
  IBaseLibraryHandle:= LoadLibrary(fbclib);
  {$IFDEF Windows}
  if IBaseLibraryHandle = NilHandle then
    IBaseLibraryHandle:= LoadLibrary(seclib);
  if IBaseLibraryHandle = NilHandle then
    IBaseLibraryHandle:= LoadLibrary(thirdlib);
  {$ENDIF}

  // Check Firebird library existance
  if (IBaseLibraryHandle = nilhandle) then
    Application.MessageBox('  لا يمكن  تحميل مكتبة فايربيرد  ' + fbclib, 'تحذير', 0);
  Application.CreateForm(Tfstart, fstart);
  Application.CreateForm(TForm1, Form1);
   Application.CreateForm(TFcreate, Fcreate);
  Application.CreateForm(TFconnect, Fconnect);
  Application.CreateForm(TDataM, DataM);
  Application.CreateForm(Tfinfo, finfo);
  Application.CreateForm(Tfstok, fstok);
  Application.CreateForm(TFaddproduit, Faddproduit);
  Application.CreateForm(TFvente, Fvente);
  Application.CreateForm(Tftrans, ftrans);
  Application.CreateForm(TFinfoSO, FinfoSO);
  Application.CreateForm(TFparam, Fparam);
  Application.CreateForm(TFapropos, Fapropos);
  Application.CreateForm(TFfindpro, Ffindpro);
  Application.Run;
end.

