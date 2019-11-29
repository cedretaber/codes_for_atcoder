import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    int n, c = 0;
    for (;;) {
        n += ++c;
        if (n == N) break;
        if (n > N) {
            writeln("No");
            return;
        }
    }

    int[][] r;
    r.length = c+1;
    int i;
    n = 0;
    while (n < N) {
        auto m = n + 1;
        foreach (d; m..m+c) r[i] ~= d;
        foreach (j; i+1..i+c+1) r[j] ~= m++;
        n += c;
        c--;
        i++;
    }
    writeln("Yes");
    writeln(r.length);
    foreach (l; r) {
        writeln(l.length, " ", l.to!(string[]).join(" "));
    }
}