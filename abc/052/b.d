import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

void main()
{
    auto _x = readln;
    auto s = readln.chomp;
    int x, max;
    foreach (c; s) {
        switch (c) {
            case 'I':
                if (++x > max) max = x;
                break;
            case 'D':
                --x;
                break;
            default:
        }
    }
    writeln(max);
}