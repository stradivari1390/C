{ TODO: �� ࠡ�⠥� }

{ ������ ��������-��ठ}

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
{  assign(input, 'dijkstra.in');}
  assign(input, 'negcycle.in');
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

{
 Function (!) to find shortest pathes from one vertex to all other,
 without asumpation, that all edge weights are nonnegative. This
 function implements Bellman-Ford algo. The return value is FALSE when
 there exists cycle with negative weight. TRUE otherwise.
 Time complexity is O(V*E) ~ O(V^3) for full graph.
}

function bellman_ford(s: integer): boolean;
var
  i, j, k: integer;
begin
  for i := 1 to N do
  begin
    p[i] := -1;
    d[i] := maxlongint;
  end;

  p[s] := 0;
  d[s] := 0;

  for i := 1 to n do                  { 横� �� �ᥬ ���設�� �஬� ��⮪� }
  begin
    for j := 1 to n do                  { ��� ��� ���設 }
      if (d[j] > d[i]+a[i, j]) then     { �१ m ����� ���� �� j ����॥ }
      begin
        d[j] := d[i] + a[i, j];         { 㬥��蠥� ����ﭨ� �� ��⮪� }
        p[j] := i;                      { �����塞 �।�� j }
      end;
  end;

  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      if (a[i, j] <> oo) and
        (d[i] > d[j] + a[j, i]) then
      begin
        bellman_ford := false;
        exit;
      end;
    end;
  end;

  bellman_ford := true;
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

  if not bellman_ford(1) then
    write('������ ����⥫�� 横�')
  else
    write('�� ������ ����⥫�� 横�');

  print;
  write('���砩訩 ���� �� 1-�� ���設� � 4-�� ���設�: ');
  write_path(1, 4);
end.

