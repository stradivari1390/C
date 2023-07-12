{ breath-first search (shortest path) }

const
  maxn = 250;

const
  queue_size = maxn;

type
  item = integer;

  queue = record
    a: array [0..queue_size] of item;
    head, tail: integer;
  end;

procedure init_queue(var q: queue);
begin
  q.head := 0;
  q.tail := 0;
end;

procedure push_to_queue(var q: queue; x: item);
begin
  with q do
  begin
    a[tail] := x;
    tail := (tail + 1) mod queue_size;
  end;
end;

function pop_from_queue(var q: queue): item;
begin
  with q do
  begin
    pop_from_queue := a[head];
    head := (head + 1) mod queue_size;
  end;
end;

function is_queue_empty(const q: queue): boolean;
begin
  is_queue_empty := q.head = q.tail;
end;

function get_queue_top(const q: queue): item;
begin
  get_queue_top := q.a[q.head];
end;


var
  a: array [1..maxn, 1..maxn] of boolean;
  p: array [1..maxn] of integer;
  q: queue;
  visited: array [1..maxn] of boolean;
  n, c: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(p, sizeof(p), 0);
  fillchar(visited, sizeof(visited), false);
  c := 1;

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

procedure bfs(v: longint);
var
  i: integer;
begin
  init_queue(q);
  push_to_queue(q, v);
  p[v] := 0;
  inc(c);
  visited[v] := true;

  while not is_queue_empty(q) do
  begin
    v := pop_from_queue(q);
    for i := 1 to n do
      if a[v, i] and not visited[i] then
      begin
        p[i] := v;
        visited[i] := true;
        push_to_queue(q, i);
      end;
  end;
end;


procedure print_path(x, y: longint);
begin
  if x <> y then
    print_path(x, p[y]);
  write(y, ' ');
end;

var
  i, j: longint;

begin
  init;

  for i := 1 to n do
    if not visited[i] then
      bfs(i);

  writeln('breath-first search (shortest path)');

  for i := 1 to n do
  begin
    write('[', 1, '->', i, '] ');
    print_path(1, i);
    writeln;
  end;

{  print;}
end.

