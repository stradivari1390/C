{ digraphs (is dag) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  p: array [1..maxn] of word;
  pre, post: array [1..maxn] of word;
  pre_c, post_c, depth, n: longint;
  is_dag: boolean;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(p, sizeof(p), false);
  fillchar(pre, sizeof(pre), 0);
  fillchar(post, sizeof(post), 0);
  depth := -1;
  pre_c := 1;
  post_c := 1;
  is_dag := true;

{  assign(input, 'digraph.in');}
  assign(input, 'dag.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    a[x, y] := true;
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
    if a[v, i] then
      if pre[i]=0 then
      begin
        p[i] := v;
        dfs(i);
      end
      else if post[i] = 0 then
        is_dag := false;                { v->i is back edge }

  post[v] := post_c;
  inc(post_c);
end;

var
  i: longint;

begin
  init;

  writeln('digraphs (is dag)');
  for i := 1 to n do
    if pre[i]=0 then
      dfs(i);

  writeln('is dag: ', is_dag);
  print;
end.