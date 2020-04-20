import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int a, b;
    foreach (c; readln.chomp) {
        if (c == '0') {
            ++a;
        } else {
            ++b;
        }
    }
    writeln(min(a, b) * 2);
}