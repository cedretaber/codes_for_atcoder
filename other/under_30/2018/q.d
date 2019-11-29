import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[30] CNT;

void main()
{
    readln;
    auto AS = readln.split.to!(int[]);
    foreach (a; AS) {
        ++CNT[a];
    }
    foreach (cnt; CNT) writeln(cnt);
}