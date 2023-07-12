{$n+}
const
  maxn = 100000;

var
  a: array [1..maxn] of longint;
  n: longint;
  p: extended;

procedure init;
var
  code: integer;
begin
  randomize;

  assign(output, 'randw.in');
  rewrite(output);

  val(paramstr(1), n, code);
  val(paramstr(2), p, code);
end;

procedure run;
var
  k, nn, i, j, nnn: longint;
begin
  nn := round((n*(n-1)) * (p / 100));   { orgraph }
{  nn := round((n*(n-1) div 2) * (p / 100));}
  nnn := round(nn / n);

  writeln(n, ' ', nn);

  for i := 1 to n do
  begin
    fillchar(a, sizeof(a), 0);
    for j := 1 to nnn do
    begin
      while true do
      begin
        k := random(n)+1;
        if a[k] = 0 then
          break;
      end;
      a[k] := random(maxint div 2);
    end;
    for j := 1 to n do
      if a[j] <> 0 then
        writeln(i, ' ', j, ' ', a[j]);
  end;

end;

procedure done;
begin
  close(output);
end;

begin
  init;
  run;
  done;
end.