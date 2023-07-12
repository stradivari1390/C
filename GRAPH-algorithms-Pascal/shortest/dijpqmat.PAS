{ shortest path from one to all (Dijkstra's algorithm) }

const
  maxn = 5000;
  inf  = $ff;

type
  key_type = byte;

  tarray = array [1..maxn] of key_type;
  parray = ^tarray;

type
  priority_queue = object
{  private}
    a: parray;
    pq, qp: array [1..maxn] of integer;
    d, n: integer;
    procedure exch(i, j: integer);
    procedure fixup(k: integer);
    procedure fixdown(k, nn: integer);

  public
    constructor init(aa: parray; ad: integer);
    function empty: boolean;
    procedure insert(v: integer);
    function getmin: integer;
    procedure lower(k: integer);

  end;

{ priority_queue }

procedure priority_queue.exch(i, j: integer);
var
  t: integer;
begin
  t := pq[i]; pq[i] := pq[j]; pq[j] := t;
  qp[pq[i]] := i;
  qp[pq[j]] := j;
end;

procedure priority_queue.fixup(k: integer);
begin
  while (k > 1) and (a^[pq[(k+d-2) div d]] > a^[pq[k]]) do
  begin
    exch(k, (k+d-2) div d);
    k := (k+d-2) div d;
  end;
end;

procedure priority_queue.fixdown(k, nn: integer);
var
  j, i: integer;
begin
  j := d*(k-1)+2;

  while j <= nn  do
  begin
    i := j + 1;
    while (i < j + d) and (i <= nn) do
    begin
      if (a^[pq[j]] > a^[pq[i]]) then
        j := i;
      inc(i);
    end;
    if a^[pq[k]] <= a^[pq[j]] then
      break;
    exch(k, j);
    k := j;
    j := d*(k-1)+2;
  end;
end;

constructor priority_queue.init(aa: parray; ad: integer);
begin
  d := ad;
  a := aa;
end;

function priority_queue.empty: boolean;
begin
  empty := n = 0;
end;

procedure priority_queue.insert(v: integer);
begin
  inc(n);
  pq[n] := v;
  qp[v] := n;
  fixup(n);
end;

function priority_queue.getmin: integer;
begin
  exch(1, n);
  fixdown(1, n-1);
  getmin := pq[n];
  dec(n);
end;

procedure priority_queue.lower(k: integer);
begin
  fixup(qp[k]);
end;

{ main program }

var
  a: array [1..maxn, 1..maxn] of byte;
  d: array [1..maxn] of longint;
  p: array [1..maxn] of integer;
  pq: priority_queue;
  n: longint;

procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  for i := 1 to maxn do
    for j := 1 to maxn do
      a[i, j] := inf;

  fillchar(d, sizeof(d), 0);
  fillchar(p, sizeof(p), 0);

{  assign(input, 'dijkstra.in');}
  assign(input, 'randw.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    a[x, y] := z;
{    a[y, x] := z;}                       { если неориентированный граф }
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
      write(a[i, j]:3);
    writeln;
  end;
end;

procedure dijkstra(s: integer);
var
  v, w: integer;
begin
  pq.init(@d, 2);

  for v := 1 to n do
  begin
    pq.insert(v);
    d[v] := a[s, v];
    p[v] := s;
  end;

  d[s] := 0;
  p[s] := 0;
  pq.lower(s);

  while not pq.empty do
  begin
    v := pq.getmin;
    {d[v] := 0;}
    if (v <> s) and (p[v] = 0) then
      exit;

    for w := 1 to n do
      if (d[v] + a[v, w] < d[w]) then
      begin
        d[w] := d[v] + a[v, w];
        pq.lower(w);
        p[w] := v;
      end;
  end;
end;


begin
  init;

  writeln('shortest path from one to all (Dijkstra''s algorithm)');

  dijkstra(1);
{  print;}
end.