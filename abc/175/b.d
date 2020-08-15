import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto LS = readln.split.to!(long[]);
    sort(LS);
    int r;
    foreach (i; 0..N-2) {
        foreach (j; i+1..N-1) {
            foreach (k; j+1..N) {
                if (LS[i] != LS[j] && LS[j] != LS[k] && LS[i] + LS[j] > LS[k]) {
                    ++r;
                }
            }
        }
    }
    writeln(r);
}