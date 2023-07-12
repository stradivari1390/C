{ breath-first search (order) }
{ поиск в ширину }

const
  maxn = 250;                           { максимальное количество вершин }

const
  queue_size = maxn;                    { размер очереди }

type
  item = integer;                       { тип элемента очереди }

  queue = record                        { очередь на базе массива }
    a: array [0..queue_size] of item;
    head, tail: integer;                { голова и хвост }
  end;

{ инициализация очереди }
procedure init_queue(var q: queue);
begin
  q.head := 0;
  q.tail := 0;
end;

{ положить в очередь }
procedure push_to_queue(var q: queue; x: item);
begin
  with q do
  begin
    a[tail] := x;
    tail := (tail + 1) mod queue_size;
  end;
end;

{ взять из очереди }
function pop_from_queue(var q: queue): item;
begin
  with q do
  begin
    pop_from_queue := a[head];
    head := (head + 1) mod queue_size;
  end;
end;

{ проверить пуста ли очередь }
function is_queue_empty(const q: queue): boolean;
begin
  is_queue_empty := q.head = q.tail;
end;


var
  a: array [1..maxn, 1..maxn] of boolean;       { матрица смежности }
  q: queue;                                     { очередь }
  visited: array [1..maxn] of boolean;          { посещена ли вершина }
  n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);                { инициализация данных }
  fillchar(visited, sizeof(visited), false);

  assign(input, 'graph.in');                    { чтение данных }
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

{ печать матрицы смежности }
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

{ поиск в ширину }
{ v - вершина исток }
procedure bfs(v: longint);
var
  i: integer;
begin
  init_queue(q);
  push_to_queue(q, v);                   { положим верину v в очередь }
  visited[v] := true;                    { вершина v посещена }

  while not is_queue_empty(q) do         { пока очередь не пуста }
  begin
    v := pop_from_queue(q);              { достаем из очереди вершину }
    for i := 1 to n do                   { перебираем все вершниы }
      if a[v, i] and not visited[i] then { если вершина смежная и }
      begin                              { непосещенная }
        visited[i] := true;              { вершина i - посещена }
        push_to_queue(q, i);             { положим вершину i в очередь }
      end;
    write(v, ' ');                       { обработка вершины }
  end;
end;

var
  i: longint;

begin
  init;

  writeln('breath-first search (order)');
  for i := 1 to n do                     { для всех непосещенных вершин }
    if not visited[i] then
      bfs(i);                            { вызовем поиск в ширину }

  print;
end.

