import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(uint[]);
    int[uint] MEMO;
    foreach (a; as) {
        if (a !in MEMO) MEMO[a] = 0;
        ++MEMO[a];
    }
    uint[] ns;
    foreach (k, _; MEMO) ns ~= k;
    if (ns.length == 1) {
        if (ns[0] == 0) {
            writeln("Yes");
        } else {
            writeln("No");
        }
    } else if (ns.length == 2) {
        if (0 in MEMO && MEMO[0] >= N/3 && MEMO[0] <= N/3+1) {
            writeln("Yes");
        } else {
            writeln("No");
        }
    } else if (ns.length == 3) {
        auto a = ns[0];
        auto b = ns[1];
        auto c = ns[2];
        if (a^b^c) goto ng;
        foreach (n; ns) {
            if (MEMO[n] < N/3 || N/3+1 <= MEMO[n]) goto ng;
        }
        writeln("Yes");
        return;
        ng:
        writeln("No");
    } else {
        writeln("No");
    }
}