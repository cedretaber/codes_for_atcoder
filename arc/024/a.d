import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    readln;
    auto ls = readln.split.to!(int[]);
    auto rs = readln.split.to!(int[]);
    sort(ls);
    sort(rs);
    int s;
    size_t i, j;
    for (;;) {
        if (i >= ls.length || j >= rs.length) break;
        if (ls[i] > rs[j]) {
            ++j;
        } else if (ls[i] < rs[j]) {
            ++i;
        } else {
            ++s;
            ++i;
            ++j;
        }
    }
    writeln(s);
}