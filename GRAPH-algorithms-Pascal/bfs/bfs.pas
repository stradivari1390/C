{ breath-first search (order) }
{ ���� � �ਭ� }

const
  maxn = 250;                           { ���ᨬ��쭮� ������⢮ ���設 }

const
  queue_size = maxn;                    { ࠧ��� ��।� }

type
  item = integer;                       { ⨯ ����� ��।� }

  queue = record                        { ��।� �� ���� ���ᨢ� }
    a: array [0..queue_size] of item;
    head, tail: integer;                { ������ � 墮�� }
  end;

{ ���樠������ ��।� }
procedure init_queue(var q: queue);
begin
  q.head := 0;
  q.tail := 0;
end;

{ �������� � ��।� }
procedure push_to_queue(var q: queue; x: item);
begin
  with q do
  begin
    a[tail] := x;
    tail := (tail + 1) mod queue_size;
  end;
end;

{ ����� �� ��।� }
function pop_from_queue(var q: queue): item;
begin
  with q do
  begin
    pop_from_queue := a[head];
    head := (head + 1) mod queue_size;
  end;
end;

{ �஢���� ���� �� ��।� }
function is_queue_empty(const q: queue): boolean;
begin
  is_queue_empty := q.head = q.tail;
end;


var
  a: array [1..maxn, 1..maxn] of boolean;       { ����� ᬥ����� }
  q: queue;                                     { ��।� }
  visited: array [1..maxn] of boolean;          { ���饭� �� ���設� }
  n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);                { ���樠������ ������ }
  fillchar(visited, sizeof(visited), false);

  assign(input, 'graph.in');                    { �⥭�� ������ }
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

{ ����� ������ ᬥ����� }
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

{ ���� � �ਭ� }
{ v - ���設� ��⮪ }
procedure bfs(v: longint);
var
  i: integer;
begin
  init_queue(q);
  push_to_queue(q, v);                   { ������� ��ਭ� v � ��।� }
  visited[v] := true;                    { ���設� v ���饭� }

  while not is_queue_empty(q) do         { ���� ��।� �� ���� }
  begin
    v := pop_from_queue(q);              { ���⠥� �� ��।� ���設� }
    for i := 1 to n do                   { ��ॡ�ࠥ� �� ���譨� }
      if a[v, i] and not visited[i] then { �᫨ ���設� ᬥ���� � }
      begin                              { �����饭��� }
        visited[i] := true;              { ���設� i - ���饭� }
        push_to_queue(q, i);             { ������� ���設� i � ��।� }
      end;
    write(v, ' ');                       { ��ࠡ�⪠ ���設� }
  end;
end;

var
  i: longint;

begin
  init;

  writeln('breath-first search (order)');
  for i := 1 to n do                     { ��� ��� �����饭��� ���設 }
    if not visited[i] then
      bfs(i);                            { �맮��� ���� � �ਭ� }

  print;
end.

