{ minimal spanning tree (Prim's algorithm) }
{ adjacency lists}

const
  maxn = 50000;
  inf  = maxint div 2;

type
  pnode = ^tnode;
  tnode = record
    v: word;
    weight: integer;
    next: pnode;
  end;

var
  a: array [1..maxn] of pnode;
  d: array [1..maxn] of longint;
  p: array [1..maxn] of integer;
  v: array [1..maxn] of boolean;
  s, n: longint;

procedure insert_vertex(v, w: word; weight: integer);
var
  p: pnode;
begin
  new(p);
  p^.v := w;
  p^.weight := weight;

  p^.next := a[v];
  a[v] := p;
end;


procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  for i := 1 to maxn do
  begin
    a[i] := nil;
    d[i] := inf;
  end;

  fillchar(p, sizeof(p), 0);
  fillchar(v, sizeof(v), false);

{  assign(input, 'mst.in');}
  assign(input, 'randw.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    insert_vertex(x, y, z);
    insert_vertex(y, x, z);             { если неориентированный граф }
  end;
end;

procedure print;
var
  i: longint;
  p: pnode;
begin
  writeln;
  writeln('number of vertex : ', n);
  writeln('adjacency lists');
  for i := 1 to n do
  begin
    p := a[i];
    write('[', i, '] ');
    while p <> nil do
    begin
      write(p^.v, ' (', p^.weight, ')  ');
      p := p^.next;
    end;
    writeln;
  end;
end;

procedure prim;
var
  i, min, j, k: longint;
  t: pnode;
begin
  k := 1;
  v[1] := true;

  for i := 2 to n do
    p[i] := 1;

  t := a[1];
  while t <> nil do
  begin
    d[t^.v] := t^.weight;
    t := t^.next;
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

{    writeln(k, ' ', p[k]);}

    v[k] := true;

    t := a[k];
    while t <> nil do
    begin
      if (not v[t^.v]) and (d[t^.v] > t^.weight) then
      begin
        p[t^.v] := k;
        d[t^.v] := t^.weight;
      end;
      t := t^.next;
    end;
  end;
end;

begin
  init;

  writeln('minimal spanning tree (Prim''s algorithm)');

  prim;
{  print;}
end.