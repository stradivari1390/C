{ minimal spanning tree (Prim's algorithm) }

const
  maxn = 100;
  inf  = maxint div 2;

var
  a: array [1..maxn, 1..maxn] of integer;
  v: array [1..maxn] of boolean;
  d: array [1..maxn] of longint;
  p: array [1..maxn] of integer;
  n: longint;
  mst_weight: longint;

procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  mst_weight := 0;
  for i := 1 to maxn do
    for j := 1 to maxn do
      a[i, j] := inf;

  fillchar(v, sizeof(v), false);
  fillchar(d, sizeof(d), 0);
  fillchar(p, sizeof(p), 0);

  assign(input, 'mst.in');
{  assign(input, 'randw.in');}
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    a[x, y] := z;
    a[y, x] := z;                       { если неориентированный граф }
  end;
end;

procedure print;
var
  i, j: integer;
begin
  writeln;
  writeln('number of vertex : ', n);
  writeln('adjacency matrix');
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(a[i, j]:3);
    writeln;
  end;
end;

procedure prim;
var
  i, min, j, k: longint;

begin
  k := 1;
  v[1] := true;

  for i := 2 to n do
  begin
    d[i] := a[i, 1];
    p[i] := 1;
  end;

  for i := 1 to n - 1 do
  begin
    min := inf;
    for j := 1 to n do
      if (not v[j]) and (d[j] < min) then
      begin
        min := d[j];
        k := j;
      end;

{    writeln(k, ' ', p[k]);             { вывод ребра }
    inc(mst_weight, a[k, p[k]]);

    v[k] := true;

    for j := 1 to n do
      if not v[j] and (d[j] > a[k, j]) then
      begin
        p[j] := k;
        d[j] := a[k, j];
      end;
  end;
end;


begin
  init;

  writeln('minimal spanning tree (Prim''s algorithm)');

  prim;
{  print;}
  writeln('mst weight = ', mst_weight);
end.