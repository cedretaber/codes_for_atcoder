import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto DS = readln.split.to!(int[]);
    auto JS = readln.split.to!(int[]);
    int s;
    foreach (i; 0..7) {
        s += DS[i] > JS[i] ? DS[i] : JS[i];
    }
    writeln(s);
}