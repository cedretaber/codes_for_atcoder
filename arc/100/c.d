import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    foreach (i; 0..N) {
        AS[i] = AS[i] - (i+1);
    }
    sort(AS);
    auto d = AS[N/2];
    long ret;
    foreach (a; AS) {
        ret += abs(a - d);
    }
    writeln(ret);
}