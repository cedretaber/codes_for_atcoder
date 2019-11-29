import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    auto BS = readln.split.to!(long[]);

    long r;
    foreach (i; 0..N) {
        if (BS[i] <= AS[i]) {
            r += BS[i];
        } else {
            r += AS[i];
            auto d = BS[i] - AS[i];
            if (AS[i+1] < d) {
                r += AS[i+1];
                AS[i+1] = 0;
            } else {
                r += d;
                AS[i+1] -= d;
            }
        }
    }
    writeln(r);
}