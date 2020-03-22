import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] as;
    auto MEMO = new long[](N+1);
    foreach (a; readln.split.to!(long[])) {
        ++MEMO[a];
        as ~= a;
    }
    long r;
    foreach (n; MEMO) {
        r += n * (n-1) / 2;
    }
    foreach (a; as) {
        auto n = MEMO[a];
        writeln(r - n * (n-1) / 2 + (n-1) * (n-2) / 2);
    }
}