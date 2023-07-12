{ ���砩訥 ��� �� ������ ��⮪� � ���� � ������⥫�묨 ��ᠬ� ॡ�� }
{ ������ �������� }
{ ����� ᬥ����� }

const
  maxn = 100;                           { ���ᨬ��쭮� ���-�� ���設 }
  oo   = maxint div 2;                  { ��᪮��筮��� }

var
  a: array [1..maxn, 1..maxn] of integer; { ����� ᬥ����� }
  d: array [1..maxn] of longint;        { ���砩訥 ��� }
  p: array [1..maxn] of integer;        { ��ॢ� ���砩�� ��⥩ (SPT) }
  v: array [1..maxn] of boolean;        { �ᯮ�짮���� �� ���設� }
  n: longint;                           { ���-�� ���設 }

{ init: ���樠������ � �⥭�� ������ }
procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  for i := 1 to maxn do                 { ��� ��� ॡ�� }
    for j := 1 to maxn do
      a[i, j] := oo;

  fillchar(d, sizeof(d), 0);
  fillchar(p, sizeof(p), 0);
  fillchar(v, sizeof(v), false);        { ���設� �� �ᯮ�짮���� }

  { �⥭�� ������ }
  assign(input, 'dijkstra.in');
{  assign(input, 'randw.in');}
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    a[x, y] := z;
{    a[y, x] := z;}                       { �᫨ ���ਥ��஢���� ��� }
  end;
end;

{ print: ����� ������ ������� }
procedure print;
var
  i, j: integer;
begin
  writeln;
  writeln('������⢮ ���設: ', n);
  writeln('����� ᬥ�����');
  for i := 1 to n do
  begin
    for j := 1 to n do
      if a[i, j] = oo then
        write('oo':3)
      else
        write(a[i, j]:3);
    writeln;
  end;
end;

{ dijkstra: ������ �������� }
procedure dijkstra(s: integer);
var
  i, j, min, m: integer;
begin
  for i := 1 to n do                    { ��� ��� ���設 }
  begin
    d[i] := a[s, i];                    { ����ﭨ� �� ��⮪� }
    p[i] := s;                          { �।�� ��⮪ }
  end;

  d[s] := 0;                            { ����ﭨ� �� ��⮪� }
  p[s] := 0;                            { � ��⮪� ��� �।��� � (SPT) }
  v[s] := true;                         { ���筨� �ᯮ�짮��� }

  for i := 2 to n do                    { ��� ��� ���設 �஬� ��⮪� }
  begin
    min := oo;                          { ������ ���設� m � ��������� }
    for j := 1 to n do                  { ����ﭨ�� �� ��⮪� }
      if not v[j] and (d[j] < min) then
      begin
        min := d[j];
        m := j;
      end;

    v[m] := true;                       { ���設� m �ᯮ�짮���� }

    for j := 1 to n do                  { ��� ��� ���設 }
      if not v[j] and                   { �᫨ ���設� �� �ᯮ�짮���� � }
         (d[j] > d[m]+a[m, j]) then     { �१ m ����� ���� �� j ����॥ }
      begin
        d[j] := d[m] + a[m, j];         { 㬥��蠥� ����ﭨ� �� ��⮪� }
        p[j] := m;                      { �����塞 �।�� j }
      end;
  end;
end;

{write_path: ���� ���砩訩 ���� �� s � x }
procedure write_path(s, x: integer);
begin
  if x <> s then
    write_path(s, p[x]);

  write(x, ' ');
end;

begin
  init;
  writeln;
  writeln('���砩訥 ��� �� ������ ��⮪� � ���� � ������⥫�묨 ��ᠬ� ॡ��');
  writeln('������ ��������');

  dijkstra(1);
  print;
  write('���砩訩 ���� �� 1-�� ���設� � 4-�� ���設�: ');
  write_path(1, 4);
end.