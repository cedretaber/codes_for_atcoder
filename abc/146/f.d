import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto S = readln.chomp;
    int[] rr;
    int i, j, last;
    foreach_reverse (c; S) {
        if (c == '0') last = i;
        if (i-j == M) {
            if (last == j) {
                writeln(-1);
                return;
            }
            rr ~= (last-j);
            j = last;
        }
        ++i;
    }
    if (j != N) rr ~= (N-j);
    rr.reverse();
    writeln(rr.array().to!(string[]).join(" "));
}