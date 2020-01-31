import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    uint[101] ys;
    foreach (i; 2..101) {
        auto n = i;
        uint m;
        foreach (d; 2..i+1) {
            while (n%d == 0) {
                n /= d;
                ++m;
            }
        }
        ys[i] = m;
    }
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(uint[]);
    int x;
    foreach (a; as) x ^= ys[a];
    writeln(x == 0 ? "No" : "Yes");
}