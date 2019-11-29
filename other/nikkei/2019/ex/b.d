import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!long;
    foreach (long i; 1..N+10) {
        if (i^^2 > N) {
            writeln(i-1);
            return;
        }
    }
}