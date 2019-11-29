import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int a, b, c;
    foreach (s; readln.chomp) {
        switch (s) {
            case 'a': ++a; break;
            case 'b': ++b; break;
            case 'c': ++c; break;
            default:
        }
    }
    writeln(abs(a-b) < 2 && abs(b-c) < 2 && abs(c-a) < 2 ? "YES" : "NO");
}