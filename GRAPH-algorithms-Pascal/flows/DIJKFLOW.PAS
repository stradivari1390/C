{ ���� ���ᨬ��쭮�� ��⮪� � �� }
{ ��⮤ ��ठ-������ᮭ� }
{ ������ �������-��௠ }
{ ��� ���᪠ �㣬��⠫쭮�� ��� �ᯮ������ ������ �������� }
{ ��� ��ᠬ� ��⠥��� ���ᯮ�짮������ �ய�᪭�� ᯮᮡ����� }

{- ����⠭�� � ��६���� -}

const
  maxn = 100;                            { ����. ���-�� ���設 }
  oo   = maxint;                         { ��᪮��筮��� }

var
  { ��⮪ }
  f: array [1..maxn, 1..maxn] of integer;  { f[i, j] = -f[j, i] }
  { �ய�᪭� ᯮᮡ���� }
  c: array [1..maxn, 1..maxn] of integer;
  { ������⢮ ���ਭ}
  n: integer;

{- ������ �������� -}

{ ��६���� }

var
  { ����� �।��饩 ���設�}
  p: array [1..maxn] of integer;
  { ���饭����� }
  v: array [1..maxn] of boolean;
  { ���砩訥 ����ﭨ� �� ��⮪� }
  d: array [1..maxn] of longint;

function edge(i, j: integer): integer;
begin
  if c[i, j] - f[i, j] > 0 then
    edge := c[i, j] - f[i, j]
  else
    edge := oo;
end;

function dijkstra(s, t: integer): boolean;
var
  i, j, k: integer;
  min: longint;
begin
  fillchar(v, sizeof(v), false);

  for i := 1 to n do
  begin
    p[i] := s;
    d[i] := edge(s, i);
  end;

  p[s] := 0;
  d[s] := 0;
  v[s] := true;

  for i := 1 to n-1 do
  begin
    min := oo;

    for j := 1 to n do
      if not v[j] and (d[j] < min) then
      begin
        min := d[j];
        k   := j;
      end;

    v[k] := true;

    for j := 1 to n do
      if not v[j] and (d[j] > d[k] + edge(k, j)) then
      begin
        d[j] := d[k] + edge(k, j);
        p[j] := k;
      end;
  end;

  dijkstra := d[t] <> oo;
end;


{- �᭮��� ��楤��� -}

{ min: ������ �� ���� ����⢥���� �ᥫ }
function min(a, b: integer): integer;
begin
  if a > b then min := b else min := a;
end;

{ maxflow: ���祭�� ���ᨬ��쭮�� ��⮪� }
{ ��⮪ �࠭���� � ����� f, s-��⮪, t-�⮪ }
function maxflow(s, t: integer): integer;
var
  k: integer;
  d, flow: longint;
begin
  fillchar(f, sizeof(f), 0);            { ����塞 f }
  flow := 0;                            { ��⮪ ���⮩ }

  while dijkstra(s, t) do                    { ���� ������� ���� �� ��⮪� � }
  begin                                 { � �⮪ � ����筮� ��, �饬   }
    d := oo;                            { ॡ� � �⮬ ��� � �������쭮�  }
    k := t;                             { ���ᯮ�짮������ �ய�᪭��      }
    while k <> s do                     { ᯮᮡ������                     }
    begin
      d := min(d, c[p[k], k]-f[p[k], k]);
      k := p[k];                        { ��६ ���設�-�।�� }
    end;

    k := t;                             { ���� �� ��������� ��� �� �⮪�  }
    while k <> s do                     { � ��⮪�                         }
    begin
      f[p[k], k] := f[p[k], k] + d;     { 㢥��稢��� �� ���� ॡࠬ }
      f[k, p[k]] := f[k, p[k]] - d;     { 㬥��蠥� �� ����� ॡࠬ }
      k := p[k];                        { ��६ ���設�-�।�� }
    end;

    flow := flow + d;                   { 㢥��稢��� ��⮪ }
  end;

  maxflow := flow;                      { �����頥� ���ᨬ���� ��⮪ }
end;

{ init: ���樠������ � ���� ������ }
procedure init;
var
  m, i, x, y, z: integer;
begin
  fillchar(c, sizeof(c), 0);

  assign(input, 'flow.in');
  reset(input);

  read(n, m);

  for i := 1 to m do
  begin
    read(x, y, z);
    c[x, y] := z;
  end;

  close(input);
end;

{solve: �襭�� }
procedure solve;
begin
  writeln(maxflow(1, n));
end;

{- ������� �ணࠬ�� -}

begin
  init;
  solve;
end.