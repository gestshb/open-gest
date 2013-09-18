unit NToLettre;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,dm,dialogs;


Function  NoToTxt(TheNo:Double;MyCur:String;MySubCur:String): String;



implementation
uses home;

//======================================================================================
Function  NoToTxt(TheNo:Double;MyCur:String;MySubCur:String): String;
var
MyArry1 : Array [0..9] of String;
MyArry2 : Array [0..9] of String;
MyArry3 : Array [0..9] of String;
MyNo :String;
GetNo:String;
RdNo :String;
My100:String;
My10 :String;
My1  :String;
My11 :String;
My12 :String;
GetTxt :String;
Mybillion : String;
MyMillion : String;
MyThou :String;
MyHun : String;
MyFraction :String;
MyAnd :String;
i : Integer;
begin
if TheNo > 999999999999.99 then Exit;
if TheNo = 0 then
begin
Result := 'صفر';
Exit;
end;

MyAnd := ' و';
MyArry1[0]:='';
MyArry1[1]:='مائة';
MyArry1[2]:='مائتان';
MyArry1[3]:='ثلاثمائة';
MyArry1[4]:='أربعمائة';
MyArry1[5]:='خمسمائة';
MyArry1[6]:='ستمائة';
MyArry1[7]:='سبعمائة';
MyArry1[8]:='ثمانمائة';
MyArry1[9]:='تسعمائة';

MyArry2[0]:='';
MyArry2[1]:=' عشر';
MyArry2[2]:='عشرون';
MyArry2[3]:='ثلاثون';
MyArry2[4]:='أربعون';
MyArry2[5]:='خمسون';
MyArry2[6]:='ستون';
MyArry2[7]:='سبعون';
MyArry2[8]:='ثمانون';
MyArry2[9]:='تسعون';

MyArry3[0]:='';
MyArry3[1]:='واحد';
MyArry3[2]:='اثنان';
MyArry3[3]:='ثلاثة';
MyArry3[4]:='أربعة';
MyArry3[5]:='خمسة';
MyArry3[6]:='ستة';
MyArry3[7]:='سبعة';
MyArry3[8]:='ثمانية';
MyArry3[9]:='تسعة';
//======================

GetNo := FormatFloat('000000000000.00',TheNo);
i := 0;
while i < 15 do
begin

if i < 12 then
begin
  MyNo := Copy(GetNo,i+1,3);
end else begin
  MyNo := '0' + Copy(GetNo,i+2,2);
end;

 if StrToInt(Copy(MyNo,1,3)) > 0 then
 begin

 RdNo := Copy(MyNo,1,1);
 My100 := MyArry1[StrToInt(RdNo)] ;
 RdNo := Copy(MyNo,3,1);
 My1 := MyArry3[StrToInt(RdNo)] ;
 RdNo := Copy(MyNo,2,1);
 My10 := MyArry2[StrToInt(RdNo)] ;
 if (StrToInt(Copy(MyNo,2,2)) = 11)then
     My11 :=  'إحدى عشر';
 if (StrToInt(Copy(MyNo,2,2)) = 12)then
     My12 :='إثنى عشر' ;

 if (StrToInt(Copy(MyNo,2,2)) = 10)then
     My10 :='عشرة' ;


 if  (StrToInt(Copy(MyNo,1,1)) > 0)
 and (StrToInt(Copy(MyNo,2,2)) > 0) then
      My100 :=My100+ MyAnd;

  if  (StrToInt(Copy(MyNo,3,1)) > 0)
  and (StrToInt(Copy(MyNo,2,1)) > 1) then
       My1 :=My1+ MyAnd;

  GetTxt := My100 + My1 +  My10;

  if (StrToInt(Copy(MyNo,3,1)) = 1) and (StrToInt(Copy(MyNo,2,1)) = 1) then
    begin
      GetTxt := My100 + My11;
      if (StrToInt(Copy(MyNo,1,1)) = 0)then
      GetTxt := My11 ;
  end;

  if (StrToInt(Copy(MyNo,3,1)) = 2) and (StrToInt(Copy(MyNo,2,1)) = 1) then
    begin
       GetTxt := My100 + My12 ;
       if (StrToInt(Copy(MyNo,1,1)) = 0)then
       GetTxt := My12 ;
  end;

if (i = 0) and (GetTxt <> '') then
begin
 if (StrToInt(Copy(MyNo,1,3)) = 1) or (StrToInt(Copy(MyNo,1,3)) > 10 )then
 begin
   Mybillion := GetTxt + ' مليار';
 end else
 begin
   Mybillion := GetTxt + ' مليارات';
   if (StrToInt(Copy(MyNo,1,3)) = 2) then Mybillion :=  ' ملياران';
 end;
end;

if (i = 3) and (GetTxt <> '') then
begin
 if (StrToInt(Copy(MyNo,1,3)) = 1) or (StrToInt(Copy(MyNo,1,3)) > 10 )then
 begin
   MyMillion := GetTxt + ' مليون';
 end else
 begin
   MyMillion := GetTxt + ' ملايين';
   if (StrToInt(Copy(MyNo,1,3)) = 2) then MyMillion :=  ' مليونان';
 end;
end;

if (i = 6) and (GetTxt <> '') then
begin
 if (StrToInt(Copy(MyNo,1,3)) > 10 )then
//  if (StrToInt(Copy(MyNo,1,3)) = 1) or (StrToInt(Copy(MyNo,1,3)) > 10 )then
  begin
   MyThou := GetTxt + ' ألف';
  end else
 begin
   MyThou := GetTxt + ' آلاف';
   if (StrToInt(Copy(MyNo,3,1)) = 2) then MyThou :=  ' ألفان';
   if (StrToInt(Copy(MyNo,3,1)) = 1) then MyThou :=  ' ألف';
 end;
end;

if (i = 9) and (GetTxt <> '') then MyHun := GetTxt;
if (i = 12)and (GetTxt <> '') then MyFraction :=  GetTxt;
end;
i :=i + 3;
end;

if (MyBillion<>'') then
 begin
 if (MyMillion <> '') Or (MyThou <> '') Or (MyHun <>'')then
 MyBillion := MyBillion + MyAnd;
end;

if (MyMillion<>'') then
 begin
 if (MyThou <> '') Or (MyHun <>'') then
 MyMillion := MyMillion + MyAnd;
end;

if (MyThou <>'') then
 begin
 if (MyHun <>'') then
 MyThou := MyThou + MyAnd;
end;

if MyFraction <> '' then
begin
  if (Mybillion <> '') Or(MyMillion <> '') Or (MyThou <> '') Or (MyHun <>'')then
  begin Result := Mybillion +  MyMillion + MyThou + MyHun + ' ' + MyCur + MyAnd + MyFraction + ' ' + MySubCur ;
  end else begin Result :=  MyFraction + ' ' + MySubCur; end;

end else begin
  Result := Mybillion +  MyMillion + MyThou + MyHun + ' ' + MyCur ;
end
end;
end.

