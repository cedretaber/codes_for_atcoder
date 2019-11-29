import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto S = readln.chomp;
    char[] n;
    foreach (c; S) {
        switch (c) {
            case '0': .. case '9':
                n ~= c;
                break;
            default:
        }
    }
    writeln(n);
}