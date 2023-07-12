{ depth-first search (pre and post order) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  pre, post: array [1..maxn] of word;
  pre_c, post_c, n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(pre, sizeof(pre), 0);
  fillchar(post, sizeof(post), 0);
  pre_c  := 1;
  post_c := 1;

  assign(input, 'graph.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    a[x, y] := true;
    a[y, x] := true;                    { если неориентированный граф }
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

procedure dfs(v: longint);
var
  i: integer;
begin
  pre[v] := pre_c;
  inc(pre_c);

  for i := 1 to n do
    if (pre[i] = 0) and a[v, i] then
      dfs(i);

  post[v] := post_c;
  inc(post_c);
end;
var
  i: longint;

begin
  init;

  writeln('depth-first search (pre and post order)');
  for i := 1 to n do
    if pre[i] = 0 then
      dfs(i);

  write('pre order : ');
  for i := 1 to n do
    write(pre[i], ' ');

  writeln;

  write('post order : ');
  for i := 1 to n do
    write(post[i], ' ');

  print;
end.