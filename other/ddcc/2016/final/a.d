import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = new int[](N);
    foreach (i; 0..N) {
        ps[readln.chomp.to!int-1] = i;
    }
    auto ts = new int[](N);
    ts[0..5] = [100000, 50000, 30000, 20000, 10000];
    foreach (p; ps) {
        writeln(ts[p]);
    }
}