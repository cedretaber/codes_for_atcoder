import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto nt = readln.split.map!(to!int);
    auto n = nt[0];
    auto t = nt[1];
    auto as = readln.split.to!(long[]);

    long max = 0;
    foreach_reverse (ref a; as) {
        auto tmp = a;
        a = max - a;
        if (tmp > max) max = tmp;
    }

    as.sort!"a > b";
    auto top = as[0];
    int cnt;
    foreach (a; as) {
        if (a == top)
            ++cnt;
        else
            break;
    }
    writeln(cnt);
}