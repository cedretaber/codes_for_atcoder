import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];
    auto S = readln.chomp;
    int b, n;
    foreach (c; S) {
        switch (c) {
            case 'a':
                if (n < A+B) {
                    writeln("Yes");
                    ++n;
                } else {
                    writeln("No");
                }
                break;
            case 'b':
                if (n < A+B && b < B) {
                    ++b;
                    ++n;
                    writeln("Yes");
                } else {
                    writeln("No");
                }
                break;
            default:
                writeln("No");
        }
    }
}