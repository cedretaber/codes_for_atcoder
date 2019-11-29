import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias ST = Tuple!(int, "i", int, "s", int, "t");

int[3*10^^5+1] NS;
ST[10^^5] MS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (int i; 0..M) {
        auto st = readln.split.to!(int[]);
        auto s = st[0]-1;
        auto t = st[1]-1;
        ++NS[s];
        --NS[t+1];
        MS[i] = ST(i+1, s, t);
    }
    foreach (i; 1..N+1) {
        NS[i] += NS[i-1];
        if (NS[i-1] != 1) NS[i-1] = 0;
    }
    foreach (i; 1..N+1) NS[i] += NS[i-1];
    int[] rs;
    foreach (m; MS[0..M]) {
        if ((m.s == 0 && NS[m.t] == 0) || (m.s != 0 && NS[m.s-1] == NS[m.t])) rs ~= m.i;
    }
    sort(rs);
    writeln(rs.length);
    foreach (r; rs) writeln(r);
}