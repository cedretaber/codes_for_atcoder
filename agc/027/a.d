import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto x = nx[1];

    auto as = readln.split.to!(int[]);
    sort(as);
    int cnt;
    foreach (a; as) {
        if (a <= x) {
            ++cnt;
            x -= a;
        } else {
            writeln(cnt);
            return;
        }
    }
    if (x) --cnt;
    writeln(cnt);
}