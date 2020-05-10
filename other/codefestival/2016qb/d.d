import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] as;
    foreach (_; 0..N) as ~= readln.chomp.to!long;

    long min_p = 1;
    long r;
    foreach (a; as) {
        if (min_p == a) {
            min_p += 1;
            continue;
        }
        auto x = a / min_p;
        if (x == 0) continue;
        if (a%min_p == 0) {
            r += x-1;
            if (min_p == 1) min_p = 2;
        } else {
            r += x;
        }
    }
    writeln(r);
}