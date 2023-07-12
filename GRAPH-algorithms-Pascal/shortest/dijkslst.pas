{ shortest path from one to all (Dijkstra's algorithm) }
{ adjacency lists}

const
  maxn = 100000;
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
  visited: array [1..maxn] of boolean;
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
  fillchar(visited, sizeof(visited), false);

{  assign(input, 'dijkstra.in');}
  assign(input, 'randw.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    insert_vertex(x, y, z);
{    a[y, x] := z;}                       { если неориентированный граф }
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

procedure dijkstra(s: integer);
var
  j, i, min, v, weight: integer;
  t: pnode;
begin
  t := a[s];
  while t <> nil do
  begin
    d[t^.v] := t^.weight;
    t := t^.next;
  end;

  for v := 1 to n do
    p[v] := s;

  d[s] := 0;
  p[s] := 0;
  visited[s] := true;

  for j := 2 to n do
  begin
    min := inf;
    for i := 1 to n do
      if (not visited[i]) and (d[i] < min) then
      begin
        min := d[i];
        v := i;
      end;

    t := a[v];
    visited[v] := true;

    while t <> nil do
    begin
      if d[t^.v] > d[v] + t^.weight then
      begin
        d[t^.v] := d[v] + t^.weight;
        p[t^.v] := v;
      end;
      t := t^.next;
    end;
  end;
end;

procedure print_path(x: integer);
begin
  if x <> s then
    print_path(p[x]);
  write(x, ' ');
end;

var
  i: longint;
begin
  init;

  writeln('shortest path from one to all (Dijkstra''s algorithm)');

  s := 1;
  dijkstra(s);
{  for i := 1 to n do
    if d[i] <> inf then
      write(i, '-', d[i], ' ');

  print;}
end.