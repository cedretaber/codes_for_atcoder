import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto ts = new int[](N);
    foreach (i; 0..N) ts[i] = readln.chomp.to!int;
    auto s = ts[0] + ts[1] + ts[2];
    if (s < K) {
        writeln(3);
        return;
    }
    foreach (i, t; ts[3..$]) {
        s = s - ts[i] + ts[i+3];
        if (s < K) {
            writeln(i+4);
            return;
        }
    }
    writeln(-1);
}