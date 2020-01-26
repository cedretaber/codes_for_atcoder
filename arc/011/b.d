import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;
import std.ascii;

void main()
{
    auto N = readln.chomp.to!int;
    auto ws = readln.split.to!(char[][]);
    char[][] res;
    foreach (w; ws) {
        char[] v;
        foreach (c; w) {
            switch (std.ascii.toLower(c)) {
                case 'b': case 'c': v ~= '1'; break;
                case 'd': case 'w': v ~= '2'; break;
                case 't': case 'j': v ~= '3'; break;
                case 'f': case 'q': v ~= '4'; break;
                case 'l': case 'v': v ~= '5'; break;
                case 's': case 'x': v ~= '6'; break;
                case 'p': case 'm': v ~= '7'; break;
                case 'h': case 'k': v ~= '8'; break;
                case 'n': case 'g': v ~= '9'; break;
                case 'z': case 'r': v ~= '0'; break;
                default:
            }
        }
        if (!v.empty) res ~= v;
    }
    writeln(res.join(" "));
}