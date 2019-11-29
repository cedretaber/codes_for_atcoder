import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    if (N == 1) {
        writeln("0");
        return;
    } else if (N == 2) {
        writeln(AS[0] == AS[1] ? "1" : "0");
        return;
    }

    int cnt;
    for (size_t i = 1; i < N-1; ++i) {
        if (AS[i-1] == AS[i]) {
            ++cnt;
            AS[i] = AS[i+1] + 1;
        }
    }
    if (AS[$-2] == AS[$-1]) ++cnt;

    writeln(cnt);
}