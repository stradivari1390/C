{ minimal spanning tree (Prim's algorithm) }
{ priority queue and adjacency lists}

const
  maxn = 50000;
  inf  = maxint div 2;

type
  key_type = longint;

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

type
  pnode = ^tnode;
  tnode = record
    v: word;
    weight: integer;
    next: pnode;
  end;


var
  a: array [1..maxn] of pnode;
  d: array [1..maxn] of key_type;
  p: array [1..maxn] of integer;
  v: array [1..maxn] of boolean;
  pq: priority_queue;
  s, n: longint;

procedure insert_vertex(v, w: word; weight: integer);
var
  p: pnode;
begin
  new(p);
  p^.v := w;
  p^.weight := weight;

  p^.next := a[v];
  a[v] := p;
end;


procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  for i := 1 to maxn do
  begin
    a[i] := nil;
    d[i] := inf;
  end;

  fillchar(p, sizeof(p), 0);
  fillchar(v, sizeof(p), false);

{  assign(input, 'mst.in');}
  assign(input, 'randw.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    insert_vertex(x, y, z);
    insert_vertex(y, x, z);             { если неориентированный граф }
  end;
end;

procedure print;
var
  i: longint;
  p: pnode;
begin
  writeln;
  writeln('number of vertex : ', n);
  writeln('adjacency lists');
  for i := 1 to n do
  begin
    p := a[i];
    write('[', i, '] ');
    while p <> nil do
    begin
      write(p^.v, ' (', p^.weight, ')  ');
      p := p^.next;
    end;
    writeln;
  end;
end;

procedure prim;
var
  i, min, j, k: longint;
  t: pnode;
begin
  k := 1;
  v[k] := true;

  t := a[k];
  while t <> nil do
  begin
    d[t^.v] := t^.weight;
    t := t^.next;
  end;

  pq.init(@d, 2);

  for i := 2 to n do
  begin
    pq.insert(i);
    p[i] := k;
  end;


  for i := 1 to n - 1 do
  begin
    k := pq.getmin;

{    writeln(k, ' ', p[k]);}

    v[k] := true;

    t := a[k];
    while t <> nil do
    begin
      if (not v[t^.v]) and (d[t^.v] > t^.weight) then
      begin
        p[t^.v] := k;
        d[t^.v] := t^.weight;
        pq.lower(t^.v);
      end;
      t := t^.next;
    end;
  end;
end;


begin
  init;

  writeln('minimal spanning tree (Prim''s algorithm)');
  prim;

{  print;}
end.