import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    readln;
    auto S = readln.chomp.to!(char[]);
    int r, g, b;
    foreach (c; S) {
        switch (c) {
            case 'R':
                ++r;
                break;
            case 'G':
                ++g;
                break;
            case 'B':
                ++b;
                break;
            default:
        }
    }
    writeln(r%2 + g%2 + b%2);
}