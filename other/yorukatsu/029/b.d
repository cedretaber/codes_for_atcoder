import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    auto BS = readln.split.to!(long[]);
    long r;
    foreach (i; 0..N) {
        auto b = BS[i];
        if (AS[i] >= b) {
            r += b;
        } else {
            r += AS[i];
            auto a = max(0, AS[i+1] + AS[i] - b);
            r += AS[i+1] - a;
            AS[i+1] = a;
        }
    }
    writeln(r);
}