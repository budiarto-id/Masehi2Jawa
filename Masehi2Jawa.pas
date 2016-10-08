unit hijri;

interface

uses
Windows, Messages, SysUtils, Classes, Graphics,
Controls, Math;

type
THijriDate = record
HijriDate: integer;
HijriMonth: integer;
HijriYear: integer;
JulianDate: integer;
hDay: integer;
HijriDay: string;
end;

function IntPart(Num : real) : integer;
function WeekDay(Wdn : integer) : string;
function Gre2Hijri(var D, M, Y : word): THijriDate;
function HijriMonths(Mth : integer) : string;
function minimum(x,y:integer):integer;
var correction:integer;

implementation

function minimum(x,y:integer):integer;
var
  tanda:integer;
begin
  if abs(x)<abs(y) then
    result := x
  else
  begin
    if x<0 then
      tanda := -1
    else
      tanda := 1;
    result := y*tanda;
  end;
end;

function IntPart(Num : real) : integer;
begin
if Num < -0.0000001 then
Result := Ceil(Num - 0.0000001)
else
Result := Floor(Num + 0.0000001);
end;

function WeekDay(Wdn : integer) : string;
begin
case Wdn of
0: Result := 'Senin';
1: Result := 'Selasa';
2: Result := 'Rabu';
3: Result := 'Kamis';
4: Result := 'Jum`at';
5: Result := 'Sabtu';
6: Result := 'Minggu';
end;
end;

function Gre2Hijri(var D, M, Y : word): THijriDate;
var
jd, l, n, j : integer;
begin
if ((Y > 1582) or ((Y = 582) and (M > 10))
or ((Y = 1582) and (M = 10) and (D>14))) then
begin
jd := IntPart((1461 * (Y + 4800 +
IntPart((M - 14)/12)))/4) +
IntPart((367 * (M - 2 - 12 *
(IntPart((M - 14)/12))))/12) -
IntPart((3 * (IntPart((Y + 4900 +
IntPart((M - 14)/12))/100)))/4) + D - 32075;
end
else
begin
jd := 367 * Y - IntPart((7 * (Y + 5001 +
IntPart((M - 9)/7)))/4) + IntPart((275 * M)/9)
+ D + 1729777;
end;

l := jd -1948440 + 10632+ correction;
n := IntPart((l - 1)/10631);
l := l - 10631 * n + 354;

j := (IntPart((10985 - l)/5316)) *
(IntPart((50 * l)/17719)) + (IntPart(l/5670)) *
(IntPart((43 * l)/15238));

l := l - (IntPart((30 - j)/15)) *
(IntPart((17719 * j)/50)) - (IntPart(j/16)) *
(IntPart((15238 * j)/43)) + 29 ;

m := IntPart((24 * l)/709);
d := l - IntPart((709 * m)/24);
y := 30 * n + j - 30;

Result.HijriDate := d;
Result.HijriMonth := m;
Result.HijriYear := y;
Result.JulianDate := jd;
Result.HijriDay := WeekDay(jd mod 7);
Result.hDay := ((jd+1) mod 7);

end;

function HijriMonths(Mth : integer) : string;
begin
case Mth of
1: Result := 'Muharram';
2: Result := 'Safar';
3: Result := 'Rabi'' al-awwal';
4: Result := 'Rabi'' al-thani';
5: Result := 'Jumada al-awwal';
6: Result := 'Jumada al-thani';
7: Result := 'Rajab';
8: Result := 'Sha''ban';
9: Result := 'Ramadan';
10: Result := 'Shawwal';
11: Result := 'Dhu al-Qi''dah';
12: Result := 'Dhu al-Hijjah';
end;
end;

end.
