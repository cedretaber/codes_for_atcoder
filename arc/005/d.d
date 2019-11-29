import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    bool[11] bs;
    foreach (b; readln.chomp) bs[b - '0'] = true;

    auto P = readln.chomp;
    char[][] rs;
    int d;
    foreach (p; P) {
        d += p - '0';
        int i;
        foreach_reverse (j, b; bs) if (j && b) {
            while (d >= j) {
                if (rs.length <= i) rs.length += 1;
                rs[i] ~= j.to!char + '0';
                ++i;
                d -= j;
            }
        }
        while (rs.length > i) rs[i++] ~= '0';
    }

    writeln(rs.map!(to!string).join("+") ~ (rs.length == 1 ? "" : "="));
}