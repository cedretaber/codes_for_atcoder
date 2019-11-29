import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto np = readln.split.to!(int[]);
    auto N = np[0];
    auto P = np[1];
    auto AS = readln.split.to!(int[]);

    int c;
    foreach (a; AS) {
        if (a <= P) {
            ++c;
            P -= a;
        } else {
            break;
        }
    }
    writeln(c);
}