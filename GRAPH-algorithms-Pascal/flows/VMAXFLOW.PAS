{ ���� ���ᨬ��쭮�� ��⮪� � �� }
{ ��⮤ ��ठ-������ᮭ� }
{ ������ �������-��௠ }
{ ���㠫����� }

{- ����⠭�� � ��६���� -}

const
  maxn = 50;                            { ����. ���-�� ���設 }
  oo   = 10E10;                         { ��᪮��筮��� }

var
  { ��⮪ }
  f: array [1..maxn, 1..maxn] of real;  { f[i, j] = -f[j, i] }
  { �ய�᪭� ᯮᮡ���� }
  c: array [1..maxn, 1..maxn] of real;
  { ������⢮ ���ਭ}
  n: integer;

{- ���� � �ਭ� -}

{ ��।� }

const
  queue_size = maxn + 2;                { ࠧ��� ��।� }

type
  queue = record                        { ��।� }
    a: array [0..queue_size-1] of integer;
    head, tail: integer;
  end;

{ init_queue: ���樠����஢��� ��।� }
procedure init_queue(var q: queue);
begin
  with q do
  begin
    tail := 0;
    head := 0;
  end;
end;

{ is_queue_empty: ���� �� ��।� }
function is_queue_empty(const q: queue): boolean;
begin
  is_queue_empty := q.tail = q.head;
end;

{ push_to_queue: �������� � ��।� x}
procedure push_to_queue(var q: queue; x: integer);
begin
  with q do
  begin
    a[tail] := x;
    tail := (tail + 1) mod queue_size;
  end;
end;

{ pop_from_queue: ������ �� ��।� }
function pop_from_queue(var q: queue): integer;
begin
  with q do
  begin
    pop_from_queue := a[head];
    head := (head + 1) mod queue_size;
  end;
end;

{ ��६���� }

var
  { ����� �।��饩 ���設�}
  p: array [1..maxn] of integer;
  { ���饭����� }
  v: array [1..maxn] of boolean;
  { ��।� }
  q: queue;

{ bfs: ���� � �ਭ� ��� ��⮤� ��ठ-������ᮭ� }
{ �����頥� true, �᫨ ������� ���� �� s �� t }
function bfs(s, t: integer): boolean;
var
  i, j: integer;
begin
  fillchar(v, sizeof(v), false);        { ����塞 ���ᨢ ���饭�� }
  init_queue(q);                        { ���樠�����㥬 ��।� }
  push_to_queue(q, s);                  { ��⠫������ � ��।� ��⮪ }
  v[s] := true;                         { ���⨫� ��⮪ }
  p[s] := -1;                           { � ��⮪� ��� �।�� }

  while not is_queue_empty(q) do        { ���� ��।� �� ���� }
  begin
    i := pop_from_queue(q);             { ���⠥� ���設� �� ��।� }
    for j := 1 to n do                  { ��ॡ�ࠥ� �� ���設� }
      if not v[j] and                   { ���設� �� ���饭� }
        (c[i, j]-f[i, j] > 0) then      { ॡ� i->j ������饭��� }
      begin
        v[j] := true;                   { ���⨫� ���設� j }
        push_to_queue(q, j);            { �������� ���設� j � ��।� }
        p[j] := i;                      { i �।�� j }
      end;
  end;

  bfs := v[t];                          { ��諨 �� �� �⮪� }
end;

{- ���㠫��� -}

procedure write_flow;
var
  i, j: integer;
begin
  writeln('����� ��⮪�');
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(f[i, j]:4:0);
    writeln;
  end;
end;

{- �᭮��� ��楤��� -}

{ min: ������ �� ���� ����⢥���� �ᥫ }
function min(a, b: real): real;
begin
  if a > b then min := b else min := a;
end;

{ maxflow: ���祭�� ���ᨬ��쭮�� ��⮪� }
{ ��⮪ �࠭���� � ����� f, s-��⮪, t-�⮪ }
function maxflow(s, t: integer): real;
var
  i, j, k: integer;
  d, flow: real;
begin
  fillchar(f, sizeof(f), 0);            { ����塞 f }
  flow := 0;                            { ��⮪ ���⮩ }

  write_flow;

  while bfs(s, t) do                    { ���� ������� ���� �� ��⮪� � }
  begin                                 { � �⮪ � ����筮� ��, �饬   }
    d := oo;                            { ॡ� � �⮬ ��� � �������쭮�  }
    k := t;                             { ���ᯮ�짮������ �ய�᪭��      }
    while k <> s do                     { ᯮᮡ������                     }
    begin
      d := min(d, c[p[k], k]-f[p[k], k]);
      k := p[k];                        { ��६ ���設�-�।�� }
    end;

    write('�㣬��⠫�� ����: ');

    k := t;                             { ���� �� ��������� ��� �� �⮪�  }
    while k <> s do                     { � ��⮪�                         }
    begin
      write(k, ' ');
      f[p[k], k] := f[p[k], k] + d;     { 㢥��稢��� �� ���� ॡࠬ }
      f[k, p[k]] := f[k, p[k]] - d;     { 㬥��蠥� �� ����� ॡࠬ }
      k := p[k];                        { ��६ ���設�-�।�� }
    end;

    writeln(s);
    flow := flow + d;                   { 㢥��稢��� ��⮪ }
    writeln('��⮪ 㢥��祭 �� ', d:0:2);
    write_flow;
    readln;
  end;

  maxflow := flow;                      { �����頥� ���ᨬ���� ��⮪ }
end;

{ init: ���樠������ � ���� ������ }
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

{solve: �襭�� }
procedure solve;
begin
  writeln(maxflow(1, 6):0:2);
end;

{- ������� �ணࠬ�� -}

begin
  init;
  solve;
end.