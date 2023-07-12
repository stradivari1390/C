{ adjacency lists }
{ представление графа в виде списков смежных вершин }

const
  maxn = 250;                           { макс. кол-во врешин }

type                                    { типы для работы со списком }
  pnode = ^tnode;
  tnode = record
    v: word;
    next: pnode;
  end;

var
  a: array [1..maxn] of pnode;          { списки смежных вершин }
  n: longint;                           { кол-во ребер }

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

{init: инициализация и ввод данных }
procedure init;
var
  i, x, y, nn: longint;
begin
  for i := 1 to maxn do
    a[i] := nil;

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

{ print: печатает списки смежных вершин }
procedure print;
var
  i: longint;
  p: pnode;
begin
  writeln;
  writeln('number of vertex : ', n);
  writeln('adjacency lists');

  for i := 1 to n do                    { перебираем все вершины }
  begin
    write('[', i, '] ');

    p := a[i];                          { перебераем все вершины, }
    while p <> nil do                   { смежные с i-ой вершиной }
    begin
      write(p^.v, ' ');
      p := p^.next;                     { берем следующую вершину списка }
    end;
    writeln;
  end;
end;

begin
  init;
  print;
end.
