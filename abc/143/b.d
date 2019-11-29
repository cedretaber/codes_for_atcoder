import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ds = readln.split.to!(long[]);
    long s;
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            s += ds[i] * ds[j];
        }
    }
    writeln(s);
}