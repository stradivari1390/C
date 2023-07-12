{ priority queue }
{ очередь по приоритетам на базе многопозиционного дерева}

const
  maxn = 50;

type
  key_type = integer;

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

var
  pq: priority_queue;
  aa: array [1..maxn] of integer;

procedure init;
var
  i: integer;
begin
  randomize;
  writeln('prioryty queue');
  for i := 1 to maxn do
    aa[i] := random(1000);

  pq.init(@aa, 2);

  for i := 1 to maxn do
  begin
    pq.insert(i);
    if random(5) = 0 then
    begin
      while not pq.empty do
      begin
        write(aa[pq.getmin], ' ');
      end;
      writeln;
    end;
  end;

{  aa[1] := 6;
  aa[2] := 5;
  aa[3] := 8;
  aa[4] := 1;
  aa[5] := 4;
  aa[6] := 3;
  aa[7] := 2;

  pq.init(@aa, 2);

  for i := 1 to 7 do
    pq.insert(i);}
end;

procedure run;
begin
  while not pq.empty do
    write(aa[pq.getmin], ' ');
end;

begin
  init;
  run;
end.

