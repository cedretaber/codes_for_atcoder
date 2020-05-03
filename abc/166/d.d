import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!long;
    auto fs = new long[](1001);
    foreach (long i; 0..1001) fs[i] = i^^5;

    foreach (i; 0..1001) {
        foreach (j; 0..1001) {
            if (fs[i] - fs[j] == X) {
                writeln(i, " ", j);
                return;
            }
            if (fs[i] + fs[j] == X) {
                writeln(i, " ", -j);
                return;
            }
            if (-fs[i] + fs[j] == X) {
                writeln(-i, " ", -j);
                return;
            }
        }
    }
}