import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    bool[10] res;
    foreach (_; 0..10) {
        foreach (i, c; readln.chomp) if (c == 'o') res[i] = true;
    }
    foreach (r; res) if (!r) {
        writeln("No");
        return;
    }
    writeln("Yes");
}