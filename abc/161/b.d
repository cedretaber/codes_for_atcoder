import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] as;
    int s;
    foreach (a; readln.split.to!(int[])) {
        s += a;
        as ~= a;
    }
    sort!"a > b"(as);
    foreach (a; as[0..M]) {
        if (4 * a * M < s) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}