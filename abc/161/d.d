import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.chomp.to!int;
    long[] rnrn;
    void make(int i, long n, long l) {
        rnrn ~= n;
        if (i == 10) return;
        foreach (m; max(0, l-1)..min(10, l+2)) {
            make(i+1, n*10+m, m);
        }
    }
    foreach (i; 1..10) make(0, i, i);
    sort(rnrn);
    writeln(rnrn[K-1]);
}