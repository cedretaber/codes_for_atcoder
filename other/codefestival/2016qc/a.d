import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp;
    int i;
    foreach (c; s) {
        if (i == 0 && c == 'C') ++i;
        if (i == 1 && c == 'F') ++i;
    }
    writeln(i == 2 ? "Yes" : "No");
}