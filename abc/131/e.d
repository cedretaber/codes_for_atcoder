import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, int);

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto x = (N-1)*(N-2)/2;
    if (x < K) {
        writeln(-1);
        return;
    }

    P[] ps;
    foreach (i; 2..N+1) {
        ps ~= P(1, i);
    }
    int a = 2, b = 3;
    while (x != K) {
        --x;
        ps ~= P(a, b);
        ++b;
        if (b > N) {
            ++a;
            b = a+1;
        }
    }
    writeln(ps.length);
    foreach (p; ps) writefln("%d %d", p[0], p[1]);
}