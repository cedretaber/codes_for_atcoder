import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    foreach (i, c; S) {
        if (i%2 == 0) {
            if (c == 'L') {
                writeln("No");
                return;
            }
        } else {
            if (c == 'R') {
                writeln("No");
                return;
            }
        }
    }
    writeln("Yes");
}