{ depth-first search (adjacency lists, order) }

const
  maxn = 250;

type
  pnode = ^tnode;
  tnode = record
    v: word;
    next: pnode;
  end;

var
  a: array [1..maxn] of pnode;
  pre: array [1..maxn] of word;
  pre_c: word;
  n: longint;

{insert_vertex: вставить в граф ребро из v в w }
procedure insert_vertex(v, w: word);
var
  p: pnode;
begin
  new(p);                               { создаем узел }
  p^.v := w;

  p^.next := a[v];                      { вставляем узел }
  a[v] := p;
end;

procedure init;
var
  i, x, y, nn: longint;
begin
  for i := 1 to maxn do
    a[i] := nil;
  fillchar(pre, sizeof(pre), 0);
  pre_c := 1;

  assign(input, 'graph.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    insert_vertex(x, y);
    insert_vertex(y, x);                { если неориентированный граф }
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
      write(p^.v, ' ');
      p := p^.next;
    end;
    writeln;
  end;
end;

procedure dfs(v: word);
var
  t: pnode;
begin
  pre[v] := pre_c;
  inc(pre_c);

  write(v, ' ');

  t := a[v];
  while t <> nil do
  begin
    if pre[t^.v] = 0 then
      dfs(t^.v);
    t := t^.next;
  end;
end;

var
  i: integer;

begin
  init;

  writeln('depth-first search (adjacency lists, order)');

  for i := 1 to n do
    if pre[i] = 0 then
      dfs(1);

  print;
end.
