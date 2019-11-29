import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(wchar[]);

    int i;
    long r;
    foreach (j, s; S) {
        if (s == 'W') {
            r += j - i;
            ++i;
        }
    }
    writeln(r);
}