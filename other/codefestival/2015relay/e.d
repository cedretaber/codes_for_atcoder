import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hm = readln.split.to!(int[]);
    auto h1 = hm[0];
    auto m1 = hm[1];
    hm = readln.split.to!(int[]);
    auto h2 = hm[0];
    auto m2 = hm[1];
    if (h1 > h2 || (h1 == h2 && m1 >= m2)) {
        writeln("Yes");
        return;
    }
    m2 = m2 <= 30 ? 0 : m2-30;
    h2 = h2 <= 6 ? 0 : h2-6;
    if (h1 > h2 || (h1 == h2 && m1 >= m2)) {
        writeln("Yes");
        return;
    }

    writeln("No");
}