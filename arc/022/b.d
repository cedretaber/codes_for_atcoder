import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

bool[10^^5+1] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    size_t i;
    int r;
    foreach (j, a; AS) {
        while (MEMO[a]) {
            MEMO[AS[i++]] = false;
        }
        MEMO[a] = true;
        r = max(r, (j-i+1).to!int);
    }
    writeln(r);
}