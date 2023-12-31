{ depth-first search (edges) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  p: array [1..maxn] of word;
  pre: array [1..maxn] of word;
  pre_c, depth, n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(p, sizeof(p), false);
  fillchar(pre, sizeof(pre), false);
  depth := -1;
  pre_c := 1;
  assign(input, 'graph.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    a[x, y] := true;
    a[y, x] := true;                    { �᫨ ���ਥ��஢���� ��� }
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
      write(ord(a[i, j]));
    writeln;
  end;
end;

procedure print_edge(v, w: word; s: string);
var
  i: word;
begin
  for i := 1 to depth do
    write(' ');

  writeln(v, '-', w, ' ', s);
end;

procedure dfs(v: longint);
var
  i: integer;
begin
  pre[v] := pre_c;
  inc(pre_c);
  inc(depth);

  for i := 1 to n do
    if a[v, i] then
      if pre[i]=0 then
      begin
        print_edge(v, i, 'tree');
        p[i] := v;
        dfs(i);
      end
      else if p[v] = i then
        print_edge(v, i, 'parent')
      else if pre[i] < pre[v] then
        print_edge(v, i, 'back')
      else if pre[i] > pre[v] then
        print_edge(v, i, 'down')
      else
        print_edge(v, i, '???');
  dec(depth);
end;

var
  i: longint;

begin
  init;

  writeln('depth-first search (edges)');
  for i := 1 to n do
    if pre[i]=0 then
      dfs(i);

{  print;}
end.