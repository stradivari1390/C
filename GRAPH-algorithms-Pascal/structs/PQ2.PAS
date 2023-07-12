{ priority queue }
{ очередь по приоритетам на базе бинарного дерева}

const
  maxn = 100;

type
  key_type = integer;

  tarray = array [1..maxn] of key_type;
  parray = ^tarray;

type
  priority_queue = object

{  private}
    a: parray;
    pq, qp: array [1..maxn] of integer;
    n: integer;
    procedure exch(i, j: integer);
    procedure fixup(k: integer);
    procedure fixdown(k, nn: integer);

  public
    constructor init(aa: parray);
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
  while (k > 1) and (a^[pq[k div 2]] > a^[pq[k]]) do
  begin
    exch(k, k div 2);
    k := k div 2;
  end;
end;

procedure priority_queue.fixdown(k, nn: integer);
var
  j: integer;
begin
  while 2*k <= nn do
  begin
    j := 2*k;
    if (j < nn) and (a^[pq[j]] > a^[pq[j+1]]) then
      inc(j);
    if a^[pq[k]] <= a^[pq[j]] then
      break;
    exch(k, j);
    k := j;
  end;
end;

constructor priority_queue.init(aa: parray);
begin
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

var
  pq: priority_queue;
  aa: array [1..maxn] of integer;

procedure init;
var
  i: integer;
begin
{  for i := 1 to maxn do
    aa[i] := random(1000);

  pq.init(@aa, 3);

  for i := 1 to maxn do
    pq.insert(i);}

  aa[1] := 6;
  aa[2] := 5;
  aa[3] := 8;
  aa[4] := 1;
  aa[5] := 4;
  aa[6] := 3;
  aa[7] := 2;

  pq.init(@aa);

  for i := 1 to 7 do
    pq.insert(i);
end;

procedure run;
begin
  writeln;

  while not pq.empty do
    write(aa[pq.getmin], ' ');
end;

begin
  init;
  run;
end.

