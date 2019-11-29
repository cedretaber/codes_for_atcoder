import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto BS = readln.split.to!(int[]);

    int r;
    foreach (i; 0..N) {
        if (i == 0) {
            r += BS[i];
        } else if (i == N-1) {
            r += BS[i-1];
        } else {
            r += min(BS[i], BS[i-1]);
        }
    }
    writeln(r);
}