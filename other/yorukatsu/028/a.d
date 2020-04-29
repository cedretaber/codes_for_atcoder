import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int n;
    foreach (c; readln.chomp) {
        if (c == '+') {
            ++n;
        } else {
            --n;
        }
    }
    writeln(n);
}