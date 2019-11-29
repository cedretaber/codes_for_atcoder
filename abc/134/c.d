import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[2][200000] AS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto a = readln.chomp.to!int;
        AS[i] = [i, a];
    }
    sort!"a[1] > b[1]"(AS[0..N]);
    auto max_a = AS[0];
    auto sec_a = AS[1];
    sort!"a[0] < b[0]"(AS[0..N]);
    foreach (a; AS[0..N]) {
        if (a[0] == max_a[0]) {
            writeln(sec_a[1]);
        } else {
            writeln(max_a[1]);
        }
    }
}