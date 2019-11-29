import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    sort(AS);
    auto n = AS[$-1];
    auto kc = n/2;

    int k;
    foreach (a; AS[0..$-1]) {
        if (a == kc) {
            k = a;
            break;
        } else if (a > kc) {
            k = kc-k < a-kc ? k : a;
            break;
        }
        k = a;
    }
    writefln("%d %d", n, k);
}