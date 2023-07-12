
const
  maxn = 100;

function get_param_int(index: integer): integer;
var
  s: string;
  res, code: integer;
begin
  s := paramstr(index);
  val(s, res, code);
  get_param_int := res;
end;

var
  n, m, i, x, y, z: integer;
  a: array [1..maxn, 1..maxn] of boolean;

begin
  randomize;
  fillchar(a, sizeof(a), false);

  n := get_param_int(1);
  m := get_param_int(2);

  writeln(n, ' ', m);

  for i := 1 to m do
  begin
    x := 1;
    y := n;

    while a[x, y] do
    begin
      x := 1 + random(n);
      y := x;
      while x = y do
        y := 1 + random(n);
    end;

    a[x, y] := true;
    z := 1 + random(1000);
    writeln(x, ' ', y, ' ', z);
  end;
end.