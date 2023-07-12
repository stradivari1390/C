{ depth-first search (non recursive) }

const
  maxn = 250;

type
  stack = array [0..maxn] of word;      { stack }
                                        { stack[0] is stack pointer }

procedure init_stack(var s: stack);
begin
  s[0] := 0;
end;

function get_stack_top(const s: stack): word;
begin
  get_stack_top := s[s[0]];
end;

procedure push_to_stack(var s: stack; w: word);
begin
  inc(s[0]);
  s[s[0]] := w;
end;

function pop_from_stack(var s: stack): word;
begin
  pop_from_stack := s[s[0]];
  dec(s[0]);
end;

function is_stack_empty(const s: stack): boolean;
begin
  is_stack_empty := s[0] = 0;
end;


var
  a: array [1..maxn, 1..maxn] of boolean;
  visited: array [1..maxn] of boolean;
  p: array [1..maxn] of word;
  s: stack;
  n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(p, sizeof(p), 0);
  fillchar(visited, sizeof(visited), false);

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
  found: boolean;
begin
  visited[v] := true;
  init_stack(s);
  push_to_stack(s, v);

  while not is_stack_empty(s) do
  begin
    v := get_stack_top(s);
    found := false;

    for i := 1 to n do
      if a[v, i] and not visited[i] then
      begin
        found := true;
        break;
      end;

    if found then
    begin
      visited[i] := true;
      push_to_stack(s, i);
      p[i] := v;
    end
    else
      pop_from_stack(s);
  end;

end;

var
  i: longint;

begin
  init;

  writeln('depth-first search (non recursive)');
  for i := 1 to n do
    if not visited[i] then
      dfs(i);

  write('dfs forest : ');
  for i := 1 to n do
    write(p[i], ' ');

  print;
end.