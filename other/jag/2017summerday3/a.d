import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int r;
    foreach (c; readln.chomp) {
        switch (c) {
            case '(':
                ++r;
                break;
            case ')':
                --r;
                break;
            default:
                writeln(r);
                return;
        }
    }
}