{ поиск максимального потока в сети }
{ метод Форда-Фалкерсона }
{ алгоритм Эдмондса-Карпа }
{ визуализатор }

{- Константы и переменные -}

const
  maxn = 50;                            { макс. кол-во вершин }
  oo   = 10E10;                         { бесконечность }

var
  { поток }
  f: array [1..maxn, 1..maxn] of real;  { f[i, j] = -f[j, i] }
  { пропускные способности }
  c: array [1..maxn, 1..maxn] of real;
  { количество вешрин}
  n: integer;

{- Поиск в ширину -}

{ Очередь }

const
  queue_size = maxn + 2;                { размер очереди }

type
  queue = record                        { очередь }
    a: array [0..queue_size-1] of integer;
    head, tail: integer;
  end;

{ init_queue: инициализировать очередь }
procedure init_queue(var q: queue);
begin
  with q do
  begin
    tail := 0;
    head := 0;
  end;
end;

{ is_queue_empty: пуста ли очередь }
function is_queue_empty(const q: queue): boolean;
begin
  is_queue_empty := q.tail = q.head;
end;

{ push_to_queue: положить в очередь x}
procedure push_to_queue(var q: queue; x: integer);
begin
  with q do
  begin
    a[tail] := x;
    tail := (tail + 1) mod queue_size;
  end;
end;

{ pop_from_queue: достать из очереди }
function pop_from_queue(var q: queue): integer;
begin
  with q do
  begin
    pop_from_queue := a[head];
    head := (head + 1) mod queue_size;
  end;
end;

{ Переменные }

var
  { номер предыдущей вершины}
  p: array [1..maxn] of integer;
  { посещенность }
  v: array [1..maxn] of boolean;
  { очередь }
  q: queue;

{ bfs: поиск в ширину для метода Форда-Фалкерсона }
{ возвращает true, если существует путь от s до t }
function bfs(s, t: integer): boolean;
var
  i, j: integer;
begin
  fillchar(v, sizeof(v), false);        { обнуляем массив посещений }
  init_queue(q);                        { инициализируем очередь }
  push_to_queue(q, s);                  { заталкиваем в очередь исток }
  v[s] := true;                         { посетили исток }
  p[s] := -1;                           { у истока нет предка }

  while not is_queue_empty(q) do        { пока очередь не пуста }
  begin
    i := pop_from_queue(q);             { достаем вершину из очереди }
    for j := 1 to n do                  { перебираем все вершины }
      if not v[j] and                   { вершина не посещена }
        (c[i, j]-f[i, j] > 0) then      { ребро i->j ненасыщенное }
      begin
        v[j] := true;                   { посетили вершину j }
        push_to_queue(q, j);            { положили веришину j в очередь }
        p[j] := i;                      { i предок j }
      end;
  end;

  bfs := v[t];                          { дошли ли до стока }
end;

{- Визуалитор -}

procedure write_flow;
var
  i, j: integer;
begin
  writeln('Матрица потока');
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(f[i, j]:4:0);
    writeln;
  end;
end;

{- Основные процедуры -}

{ min: минимум из двух вещественных чисел }
function min(a, b: real): real;
begin
  if a > b then min := b else min := a;
end;

{ maxflow: значения максимального потока }
{ поток хранится в матрице f, s-исток, t-сток }
function maxflow(s, t: integer): real;
var
  i, j, k: integer;
  d, flow: real;
begin
  fillchar(f, sizeof(f), 0);            { обнуляем f }
  flow := 0;                            { поток пустой }

  write_flow;

  while bfs(s, t) do                    { Пока существует путь от истока в }
  begin                                 { в сток в остаточной сети, ищем   }
    d := oo;                            { ребро в этом пути с минимальной  }
    k := t;                             { неиспользованной пропускной      }
    while k <> s do                     { способностью                     }
    begin
      d := min(d, c[p[k], k]-f[p[k], k]);
      k := p[k];                        { берем вершину-предок }
    end;

    write('Аугментальный путь: ');

    k := t;                             { идем по найденому пути от стока  }
    while k <> s do                     { к истоку                         }
    begin
      write(k, ' ');
      f[p[k], k] := f[p[k], k] + d;     { увеличиваем по прямым ребрам }
      f[k, p[k]] := f[k, p[k]] - d;     { уменьшаем по обратным ребрам }
      k := p[k];                        { берем вершину-предок }
    end;

    writeln(s);
    flow := flow + d;                   { увеличиваем поток }
    writeln('Поток увеличен на ', d:0:2);
    write_flow;
    readln;
  end;

  maxflow := flow;                      { возвращаем максимальный поток }
end;

{ init: инициализация и ввод данных }
procedure init;
var
  m, i, x, y, z: integer;
begin
  fillchar(c, sizeof(c), 0);

  assign(input, 'flow.in');
  reset(input);

  read(n, m);

  for i := 1 to m do
  begin
    read(x, y, z);
    c[x, y] := z;
  end;

  close(input);

  assign(input, 'con');
  reset(input);
end;

{solve: решение }
procedure solve;
begin
  writeln(maxflow(1, 6):0:2);
end;

{- Главная программа -}

begin
  init;
  solve;
end.