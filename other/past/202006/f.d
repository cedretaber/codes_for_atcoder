import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto a = new dchar[][N];
    foreach (i; 0..N) a[i] = readln.chomp.to!(dchar[]);

    dchar[] h, t;
    foreach (i; 0..N/2) {
        auto j = N-i-1;
        foreach (c; a[i]) {
            foreach (d; a[j]) {
                if (c == d) {
                    h ~= c;
                    t ~= d;
                    goto ok;
                }
            }
        }
        writeln(-1);
        return;
        ok:
    }
    if (N%2 == 1) {
        h ~= a[N/2][0];
    }
    writeln(h ~ t.reverse().array());
}